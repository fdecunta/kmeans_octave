CLUSTERS  = data/outputs/classified.dat
PLOT_IRIS = ./iris_kmeans.pdf
PLOT_J    = ./j.pdf

all: $(CLUSTERS) $(PLOT_IRIS) $(PLOT_J)

clean:
	rm -f $(CLUSTERS) $(PLOT_IRIS) $(PLOT_J)

$(CLUSTERS): clustering.m data/iris.txt
	octave clustering.m

$(PLOT_IRIS): plots/iris_kmeans.gp
	cd plots && gnuplot iris_kmeans.gp

$(PLOT_J): plots/plot_j.gp
	cd plots && gnuplot plot_j.gp

