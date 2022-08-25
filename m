Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2715A1346
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiHYOOu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiHYOOc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3872B6D3C
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcf-0002wy-98; Thu, 25 Aug 2022 16:14:17 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-001un5-Bi; Thu, 25 Aug 2022 16:14:16 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwm-83; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 16/16] fpga: machxo2: add configuration over i2c
Date:   Thu, 25 Aug 2022 16:13:43 +0200
Message-Id: <20220825141343.1375690-17-j.zink@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825141343.1375690-1-j.zink@pengutronix.de>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jzi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Peter Jensen <pdj@bang-olufsen.dk>

The configuration flash of the machxo2 fpga can also be erased and
written over i2c instead of spi. Add this functionality to the
refactored common driver. Since some commands are shorter over I2C than
they are over SPI some quirks are added to the common driver in order to
account for that.

Signed-off-by: Peter Jensen <pdj@bang-olufsen.dk>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/Kconfig          |   8 ++
 drivers/fpga/Makefile         |   1 +
 drivers/fpga/machxo2-common.c |  15 +++-
 drivers/fpga/machxo2-common.h |   3 +
 drivers/fpga/machxo2-i2c.c    | 137 ++++++++++++++++++++++++++++++++++
 5 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fpga/machxo2-i2c.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index e5869a732246..97081bbd7c19 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -90,6 +90,14 @@ config FPGA_MGR_MACHXO2_SPI
 	  FPGA manager driver support for Lattice MachXO2 configuration
 	  over slave SPI interface.
 
+config FPGA_MGR_MACHXO2_I2C
+	tristate "Lattice MachXO2 I2C"
+	depends on I2C
+	select FPGA_MGR_MACHXO2_COMMON
+	help
+	  FPGA manager driver support for Lattice MachXO2 configuration
+	  over slave I2C interface.
+
 config FPGA_MGR_TS73XX
 	tristate "Technologic Systems TS-73xx SBC FPGA Manager"
 	depends on ARCH_EP93XX && MACH_TS72XX
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index f247a8de83ad..fcdf79f4d424 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI)	+= altera-ps-spi.o
 obj-$(CONFIG_FPGA_MGR_ICE40_SPI)	+= ice40-spi.o
 obj-$(CONFIG_FPGA_MGR_MACHXO2_COMMON)	+= machxo2-common.o
 obj-$(CONFIG_FPGA_MGR_MACHXO2_SPI)	+= machxo2-spi.o
+obj-$(CONFIG_FPGA_MGR_MACHXO2_I2C)	+= machxo2-i2c.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
diff --git a/drivers/fpga/machxo2-common.c b/drivers/fpga/machxo2-common.c
index e8967cdee2c6..0a3c126675da 100644
--- a/drivers/fpga/machxo2-common.c
+++ b/drivers/fpga/machxo2-common.c
@@ -100,7 +100,7 @@ static void dump_status_reg(struct device *dev, u32 status)
 		!!FIELD_GET(MACHXO2_DVER, status), get_err_string(get_err(status)));
 }
 
-static int machxo2_wait_until_not_busy(struct machxo2_common_priv *priv)
+int machxo2_wait_until_not_busy(struct machxo2_common_priv *priv)
 {
 	u32 status;
 	int ret, loop = 0;
@@ -143,6 +143,11 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
 	cmd.cmd = refresh;
 	cmd.cmd_len = sizeof(refresh);
 	cmd.delay_us = MACHXO2_REFRESH_USEC;
+
+	/* quirk: refresh command over i2c is 1 byte shorter */
+	if (priv->refresh_3b)
+		cmd.cmd_len--;
+
 	ret = priv->write_commands(priv, &cmd, 1);
 	if (ret)
 		goto fail;
@@ -207,6 +212,10 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 	cmd[0].cmd_len = sizeof(enable);
 	cmd[0].delay_us = MACHXO2_LOW_DELAY_USEC;
 
+	/* quirk: enable command over i2c is 1 byte shorter */
+	if (priv->enable_3b)
+		cmd[0].cmd_len--;
+
 	cmd[1].cmd = (u8 *)&priv->erase_cmd;
 	cmd[1].cmd_len = sizeof(priv->erase_cmd);
 
@@ -313,6 +322,10 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 	cmd.cmd_len = sizeof(refresh);
 	cmd.delay_us = MACHXO2_REFRESH_USEC;
 
+	/* quirk: refresh command over i2c is 1 byte shorter */
+	if (priv->refresh_3b)
+		cmd.cmd_len--;
+
 	do {
 		ret = priv->write_commands(priv, &cmd, 1);
 		if (ret)
diff --git a/drivers/fpga/machxo2-common.h b/drivers/fpga/machxo2-common.h
index 0f9f53b48152..8c09345adee5 100644
--- a/drivers/fpga/machxo2-common.h
+++ b/drivers/fpga/machxo2-common.h
@@ -32,9 +32,12 @@ struct machxo2_common_priv {
 	int (*get_status)(struct machxo2_common_priv *priv, u32 *status);
 	struct device *dev;
 	__be32 erase_cmd;
+	u8 enable_3b:1;
+	u8 refresh_3b:1;
 	struct gpio_desc *fpga_program_n;
 };
 
 int machxo2_common_init(struct machxo2_common_priv *priv, struct device *dev);
+int machxo2_wait_until_not_busy(struct machxo2_common_priv *priv);
 
 #endif
diff --git a/drivers/fpga/machxo2-i2c.c b/drivers/fpga/machxo2-i2c.c
new file mode 100644
index 000000000000..a309016def1c
--- /dev/null
+++ b/drivers/fpga/machxo2-i2c.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lattice MachXO2 Slave I2C Driver
+ *
+ * Manage Lattice FPGA firmware that is loaded over I2C using
+ * the slave serial configuration interface.
+ *
+ * Copyright (C) 2018 Paolo Pisati <p.pisati@gmail.com>
+ * Copyright (C) 2021 Peter Jensen <pdj@bang-olufsen.dk>
+ */
+
+#include <linux/i2c.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include "machxo2-common.h"
+
+
+struct machxo2_i2c_priv {
+	struct machxo2_common_priv common;
+	struct i2c_client *client;
+};
+
+static inline struct machxo2_i2c_priv *to_machxo2_i2c_priv(struct machxo2_common_priv *common)
+{
+	return container_of(common, struct machxo2_i2c_priv, common);
+}
+
+static int machxo2_i2c_get_status(struct machxo2_common_priv *bus, u32 *status)
+{
+	struct machxo2_i2c_priv *i2cPriv = to_machxo2_i2c_priv(bus);
+	struct i2c_client *client = i2cPriv->client;
+	u8 read_status[] = LSC_READ_STATUS;
+	__be32 tmp;
+	int ret;
+	struct i2c_msg msg[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.buf = read_status,
+			.len = ARRAY_SIZE(read_status),
+		}, {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.buf = (u8 *) &tmp,
+			.len = sizeof(tmp)
+		}
+	};
+
+	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(msg))
+		return -EIO;
+	*status = be32_to_cpu(tmp);
+
+	return 0;
+}
+
+static int machxo2_i2c_write(struct machxo2_common_priv *common,
+			     struct machxo2_cmd *cmds, size_t cmd_count)
+{
+	struct machxo2_i2c_priv *i2c_priv = to_machxo2_i2c_priv(common);
+	struct i2c_client *client = i2c_priv->client;
+	size_t i;
+	int ret;
+
+	for (i = 0; i < cmd_count; i++) {
+		struct i2c_msg msg[] = {
+			{
+				.addr = client->addr,
+				.buf = cmds[i].cmd,
+				.len = cmds[i].cmd_len,
+			},
+		};
+
+		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+		if (ret < 0)
+			return ret;
+		if (ret != ARRAY_SIZE(msg))
+			return -EIO;
+		if (cmds[i].delay_us)
+			usleep_range(cmds[i].delay_us, cmds[i].delay_us +
+				     cmds[i].delay_us / 4);
+		if (i < cmd_count - 1) /* on any iteration except for the last one... */
+			ret = machxo2_wait_until_not_busy(common);
+	}
+
+	return 0;
+}
+
+static int machxo2_i2c_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct machxo2_i2c_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(struct machxo2_i2c_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client = client;
+	priv->common.get_status = machxo2_i2c_get_status;
+	priv->common.write_commands = machxo2_i2c_write;
+
+	/* Commands are usually 4b, but these aren't for i2c */
+	priv->common.enable_3b = true;
+	priv->common.refresh_3b = true;
+
+	return machxo2_common_init(&priv->common, dev);
+}
+
+static const struct of_device_id of_match[] = {
+	{ .compatible = "lattice,machxo2-slave-i2c", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_match);
+
+static const struct i2c_device_id lattice_ids[] = {
+	{ "machxo2-slave-i2c", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, lattice_ids);
+
+static struct i2c_driver machxo2_i2c_driver = {
+	.driver = {
+		.name = "machxo2-slave-i2c",
+		.of_match_table = of_match_ptr(of_match),
+	},
+	.probe = machxo2_i2c_probe,
+	.id_table = lattice_ids,
+};
+
+module_i2c_driver(machxo2_i2c_driver);
+
+MODULE_AUTHOR("Peter Jensen <pdj@bang-olufsen.dk>");
+MODULE_DESCRIPTION("Load Lattice FPGA firmware over I2C");
+MODULE_LICENSE("GPL");
-- 
2.30.2

