Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2017C46691
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Jun 2019 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfFNRzO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Jun 2019 13:55:14 -0400
Received: from foss.arm.com ([217.140.110.172]:39528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfFNRzN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C2ED6E;
        Fri, 14 Jun 2019 10:55:12 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A9403F718;
        Fri, 14 Jun 2019 10:55:10 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 13/28] drivers: Introduce class_find_device_by_of_node() helper
Date:   Fri, 14 Jun 2019 18:54:08 +0100
Message-Id: <1560534863-15115-14-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add a wrapper to class_find_device() to search for a device
by the of_node pointer, reusing the generic match function.
Also convert the existing users to make use of the new helper.

Cc: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: linux-fpga@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>
Cc: Mark Brown <broonie@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/fpga/fpga-bridge.c       |  8 +-------
 drivers/fpga/fpga-mgr.c          |  8 +-------
 drivers/mux/core.c               |  7 +------
 drivers/net/phy/mdio_bus.c       |  9 +--------
 drivers/regulator/of_regulator.c |  7 +------
 drivers/spi/spi.c                | 11 ++---------
 include/linux/device.h           | 12 ++++++++++++
 7 files changed, 19 insertions(+), 43 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 80bd8f1..4bab902 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -19,11 +19,6 @@ static struct class *fpga_bridge_class;
 /* Lock for adding/removing bridges to linked lists*/
 static spinlock_t bridge_list_lock;
 
-static int fpga_bridge_of_node_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 /**
  * fpga_bridge_enable - Enable transactions on the bridge
  *
@@ -104,8 +99,7 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 {
 	struct device *dev;
 
-	dev = class_find_device(fpga_bridge_class, NULL, np,
-				fpga_bridge_of_node_match);
+	dev = class_find_device_by_of_node(fpga_bridge_class, np);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c386681..e05104f 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -482,11 +482,6 @@ struct fpga_manager *fpga_mgr_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_get);
 
-static int fpga_mgr_of_node_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 /**
  * of_fpga_mgr_get - Given a device node, get a reference to a fpga mgr.
  *
@@ -498,8 +493,7 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
 	struct device *dev;
 
-	dev = class_find_device(fpga_mgr_class, NULL, node,
-				fpga_mgr_of_node_match);
+	dev = class_find_device_by_of_node(fpga_mgr_class, node);
 	if (!dev)
 		return ERR_PTR(-ENODEV);
 
diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index d1271c1..1fb2238 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -405,17 +405,12 @@ int mux_control_deselect(struct mux_control *mux)
 }
 EXPORT_SYMBOL_GPL(mux_control_deselect);
 
-static int of_dev_node_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 /* Note this function returns a reference to the mux_chip dev. */
 static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = class_find_device(&mux_class, NULL, np, of_dev_node_match);
+	dev = class_find_device_by_of_node(&mux_class, np);
 
 	return dev ? to_mux_chip(dev) : NULL;
 }
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index bd04fe7..ce94087 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -262,11 +262,6 @@ static struct class mdio_bus_class = {
 };
 
 #if IS_ENABLED(CONFIG_OF_MDIO)
-/* Helper function for of_mdio_find_bus */
-static int of_mdio_bus_match(struct device *dev, const void *mdio_bus_np)
-{
-	return dev->of_node == mdio_bus_np;
-}
 /**
  * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
  * @mdio_bus_np: Pointer to the mii_bus.
@@ -287,9 +282,7 @@ struct mii_bus *of_mdio_find_bus(struct device_node *mdio_bus_np)
 	if (!mdio_bus_np)
 		return NULL;
 
-	d = class_find_device(&mdio_bus_class, NULL,  mdio_bus_np,
-			      of_mdio_bus_match);
-
+	d = class_find_device_by_of_node(&mdio_bus_class, mdio_bus_np);
 	return d ? to_mii_bus(d) : NULL;
 }
 EXPORT_SYMBOL(of_mdio_find_bus);
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 0ead116..1b40277 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -442,16 +442,11 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 	return NULL;
 }
 
-static int of_node_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = class_find_device(&regulator_class, NULL, np, of_node_match);
+	dev = class_find_device_by_of_node(&regulator_class, np);
 
 	return dev ? dev_to_rdev(dev) : NULL;
 }
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3da1121..a256be5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3554,21 +3554,14 @@ EXPORT_SYMBOL_GPL(of_find_spi_device_by_node);
 #endif /* IS_ENABLED(CONFIG_OF) */
 
 #if IS_ENABLED(CONFIG_OF_DYNAMIC)
-static int __spi_of_controller_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 /* the spi controllers are not using spi_bus, so we find it with another way */
 static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
 {
 	struct device *dev;
 
-	dev = class_find_device(&spi_master_class, NULL, node,
-				__spi_of_controller_match);
+	dev = class_find_device_by_of_node(&spi_master_class, node);
 	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device(&spi_slave_class, NULL, node,
-					__spi_of_controller_match);
+		dev = class_find_device_by_of_node(&spi_slave_class, node);
 	if (!dev)
 		return NULL;
 
diff --git a/include/linux/device.h b/include/linux/device.h
index bb14c7f..9228502 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -497,6 +497,18 @@ static inline struct device *class_find_device_by_name(struct class *class,
 	return class_find_device(class, NULL, name, device_match_name);
 }
 
+/**
+ * class_find_device_by_of_node : device iterator for locating a particular device
+ * matching the of_node.
+ * @class: class type
+ * @np: of_node of the device to match.
+ */
+static inline struct device *
+class_find_device_by_of_node(struct class *class, const struct device_node *np)
+{
+	return class_find_device(class, NULL, np, device_match_of_node);
+}
+
 struct class_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct class *class, struct class_attribute *attr,
-- 
2.7.4

