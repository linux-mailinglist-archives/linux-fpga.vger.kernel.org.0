Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150AF5A1350
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiHYOS0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiHYOOe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE7FB6036
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcf-0002ww-21; Thu, 25 Aug 2022 16:14:17 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-001umz-6L; Thu, 25 Aug 2022 16:14:16 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwX-4q; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 11/16] fpga: machxo2: move non-spi-related functionality to common code
Date:   Thu, 25 Aug 2022 16:13:38 +0200
Message-Id: <20220825141343.1375690-12-j.zink@pengutronix.de>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This commit seperates the general programming algorithm from
bus-specific access functions. This is a preparation for adding i2c as
another bus.

While at it: rename some functions to allow easier separation between
spi-specific functions and common code.

While at it: clean up includes

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/Kconfig          |   6 +
 drivers/fpga/Makefile         |   1 +
 drivers/fpga/machxo2-common.c | 310 +++++++++++++++++++++++++++++++++
 drivers/fpga/machxo2-common.h |  37 ++++
 drivers/fpga/machxo2-spi.c    | 318 +---------------------------------
 5 files changed, 359 insertions(+), 313 deletions(-)
 create mode 100644 drivers/fpga/machxo2-common.c
 create mode 100644 drivers/fpga/machxo2-common.h

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 6c416955da53..e5869a732246 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -77,9 +77,15 @@ config FPGA_MGR_ICE40_SPI
 	help
 	  FPGA manager driver support for Lattice iCE40 FPGAs over SPI.
 
+config FPGA_MGR_MACHXO2_COMMON
+	tristate
+	help
+	  FPGA manager driver common code for Lattice MachXO2 configuration
+
 config FPGA_MGR_MACHXO2_SPI
 	tristate "Lattice MachXO2 SPI"
 	depends on SPI
+	select FPGA_MGR_MACHXO2_COMMON
 	help
 	  FPGA manager driver support for Lattice MachXO2 configuration
 	  over slave SPI interface.
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 42ae8b58abce..f247a8de83ad 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_FPGA)			+= fpga-mgr.o
 obj-$(CONFIG_FPGA_MGR_ALTERA_CVP)	+= altera-cvp.o
 obj-$(CONFIG_FPGA_MGR_ALTERA_PS_SPI)	+= altera-ps-spi.o
 obj-$(CONFIG_FPGA_MGR_ICE40_SPI)	+= ice40-spi.o
+obj-$(CONFIG_FPGA_MGR_MACHXO2_COMMON)	+= machxo2-common.o
 obj-$(CONFIG_FPGA_MGR_MACHXO2_SPI)	+= machxo2-spi.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
diff --git a/drivers/fpga/machxo2-common.c b/drivers/fpga/machxo2-common.c
new file mode 100644
index 000000000000..33127ee67d19
--- /dev/null
+++ b/drivers/fpga/machxo2-common.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Lattice MachXO2 Common Driver
+ *
+ * Manage Lattice FPGA firmware
+ *
+ * Copyright (C) 2018 Paolo Pisati <p.pisati@gmail.com>
+ * Copyright (C) 2022 Pengutronix, Johannes Zink <kernel@pengutronix.de>
+ */
+
+#include <linux/delay.h>
+#include <linux/bitfield.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include "machxo2-common.h"
+
+#define MACHXO2_LOW_DELAY_USEC          5
+#define MACHXO2_HIGH_DELAY_USEC         200
+#define MACHXO2_REFRESH_USEC            4800
+#define MACHXO2_MAX_BUSY_LOOP           128
+#define MACHXO2_MAX_REFRESH_LOOP        16
+
+#define MACHXO2_PAGE_SIZE               16
+#define MACHXO2_BUF_SIZE                (MACHXO2_PAGE_SIZE + 4)
+
+/* Status register bits, errors and error mask */
+#define MACHXO2_BUSY		BIT(12)
+#define MACHXO2_DONE		BIT(8)
+#define MACHXO2_DVER		BIT(27)
+#define MACHXO2_ENAB		BIT(9)
+#define MACHXO2_ERR		GENMASK(25, 23)
+#define MACHXO2_ERR_ENOERR	0 /* no error */
+#define MACHXO2_ERR_EEID	1
+#define MACHXO2_ERR_EECMD	2
+#define MACHXO2_ERR_EECRC	3
+#define MACHXO2_ERR_EEPREAM	4 /* preamble error */
+#define MACHXO2_ERR_EEABRT	5 /* abort error */
+#define MACHXO2_ERR_EEOVERFL	6 /* overflow error */
+#define MACHXO2_ERR_EESDMEOF	7 /* SDM EOF */
+#define MACHXO2_FAIL		BIT(13)
+
+
+static inline u8 get_err(u32 status)
+{
+	return FIELD_GET(MACHXO2_ERR, status);
+}
+
+static const char *get_err_string(u8 err)
+{
+	switch (err) {
+	case MACHXO2_ERR_ENOERR:	return "No Error";
+	case MACHXO2_ERR_EEID:		return "ID ERR";
+	case MACHXO2_ERR_EECMD:		return "CMD ERR";
+	case MACHXO2_ERR_EECRC:		return "CRC ERR";
+	case MACHXO2_ERR_EEPREAM:	return "Preamble ERR";
+	case MACHXO2_ERR_EEABRT:	return "Abort ERR";
+	case MACHXO2_ERR_EEOVERFL:	return "Overflow ERR";
+	case MACHXO2_ERR_EESDMEOF:	return "SDM EOF";
+	}
+
+	return "Unknown";
+}
+
+static void dump_status_reg(u32 status)
+{
+        pr_debug("machxo2 status: 0x%08X - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
+                  status, !!FIELD_GET(MACHXO2_DONE, status), !!FIELD_GET(MACHXO2_ENAB, status),
+                  !!FIELD_GET(MACHXO2_BUSY, status), !!FIELD_GET(MACHXO2_FAIL, status),
+                  !!FIELD_GET(MACHXO2_DVER, status), get_err_string(get_err(status)));
+}
+
+static int machxo2_wait_until_not_busy(struct machxo2_common_priv *priv)
+{
+	u32 status;
+	int ret, loop = 0;
+
+	do {
+		ret = priv->get_status(priv, &status);
+		if (ret)
+			return ret;
+		if (++loop >= MACHXO2_MAX_BUSY_LOOP)
+			return -EBUSY;
+	} while (status & MACHXO2_BUSY);
+
+	return 0;
+}
+
+static int machxo2_cleanup(struct fpga_manager *mgr)
+{
+	struct machxo2_common_priv *priv = mgr->priv;
+	u8 erase[] = ISC_ERASE;
+	u8 refresh[] = LSC_REFRESH;
+	struct machxo2_cmd cmd = {};
+	int ret;
+
+	cmd.cmd = erase;
+	cmd.cmd_len = sizeof(erase);
+	ret = priv->write_commands(priv, &cmd, 1);
+	if (ret)
+		goto fail;
+
+	ret = machxo2_wait_until_not_busy(priv);
+	if (ret)
+		goto fail;
+
+	cmd.cmd = refresh;
+	cmd.cmd_len = sizeof(refresh);
+	cmd.delay_us = MACHXO2_REFRESH_USEC;
+	ret = priv->write_commands(priv, &cmd, 1);
+	if (ret)
+		goto fail;
+
+	return 0;
+fail:
+	dev_err(&mgr->dev, "Cleanup failed\n");
+
+	return ret;
+}
+
+static bool machxo2_status_done(unsigned long status)
+{
+	return (((status & (MACHXO2_BUSY | MACHXO2_DONE)) == MACHXO2_DONE) &&
+		get_err(status) == MACHXO2_ERR_ENOERR);
+}
+
+static enum fpga_mgr_states machxo2_state(struct fpga_manager *mgr)
+{
+	struct machxo2_common_priv *priv = mgr->priv;
+	u32 status;
+
+	priv->get_status(priv, &status);
+	if (machxo2_status_done(status))
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int machxo2_write_init(struct fpga_manager *mgr,
+			      struct fpga_image_info *info,
+			      const char *buf, size_t count)
+{
+	struct machxo2_common_priv *priv = mgr->priv;
+	u8 enable[] = ISC_ENABLE;
+	u8 erase[] = ISC_ERASE;
+	u8 initaddr[] = LSC_INITADDRESS;
+	struct machxo2_cmd cmd[2] = {};
+	u32 status;
+	int ret;
+
+	if ((info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+		dev_err(&mgr->dev,
+			"Partial reconfiguration is not supported\n");
+		return -ENOTSUPP;
+	}
+
+	priv->get_status(priv, &status);
+	dump_status_reg(status);
+
+	cmd[0].cmd = enable;
+	cmd[0].cmd_len = sizeof(enable);
+	cmd[0].delay_us = MACHXO2_LOW_DELAY_USEC;
+
+	cmd[1].cmd = erase;
+	cmd[1].cmd_len = sizeof(erase);
+	ret = priv->write_commands(priv, cmd, 2);
+	if (ret)
+		goto fail;
+
+	ret = machxo2_wait_until_not_busy(priv);
+	if (ret)
+		goto fail;
+
+	priv->get_status(priv, &status);
+	if (status & MACHXO2_FAIL) {
+		ret = -EINVAL;
+		goto fail;
+	}
+	dump_status_reg(status);
+
+	cmd[0].cmd = initaddr;
+	cmd[0].cmd_len = sizeof(initaddr);
+	ret = priv->write_commands(priv, cmd, 1);
+	if (ret)
+		goto fail;
+
+	priv->get_status(priv, &status);
+	dump_status_reg(status);
+
+	return 0;
+fail:
+	dev_err(&mgr->dev, "Error during FPGA init.\n");
+
+	return ret;
+}
+
+static int machxo2_write(struct fpga_manager *mgr, const char *buf,
+			 size_t count)
+{
+	struct machxo2_common_priv *priv = mgr->priv;
+	u8 progincr[] = LSC_PROGINCRNV;
+	u8 payload[MACHXO2_BUF_SIZE];
+	struct machxo2_cmd cmd = {};
+	u32 status;
+	int i, ret;
+
+	if (count % MACHXO2_PAGE_SIZE != 0) {
+		dev_err(&mgr->dev, "Malformed payload.\n");
+		return -EINVAL;
+	}
+	priv->get_status(priv, &status);
+	dump_status_reg(status);
+	cmd.cmd = payload;
+	cmd.cmd_len = MACHXO2_BUF_SIZE;
+	cmd.delay_us = MACHXO2_HIGH_DELAY_USEC;
+
+	memcpy(payload, &progincr, sizeof(progincr));
+	for (i = 0; i < count; i += MACHXO2_PAGE_SIZE) {
+		memcpy(&payload[sizeof(progincr)], &buf[i], MACHXO2_PAGE_SIZE);
+
+		cmd.cmd = payload;
+		cmd.cmd_len = MACHXO2_BUF_SIZE;
+		cmd.delay_us = MACHXO2_HIGH_DELAY_USEC;
+		ret = priv->write_commands(priv, &cmd, 1);
+		if (ret) {
+			dev_err(&mgr->dev, "Error loading the bitstream.\n");
+			return ret;
+		}
+	}
+	priv->get_status(priv, &status);
+	dump_status_reg(status);
+
+	return 0;
+}
+
+static int machxo2_write_complete(struct fpga_manager *mgr,
+				  struct fpga_image_info *info)
+{
+	struct machxo2_common_priv *priv = mgr->priv;
+	struct machxo2_cmd cmd = {};
+	u8 progdone[] = ISC_PROGRAMDONE;
+	u8 refresh[] = LSC_REFRESH;
+	u32 status;
+	int ret, refreshloop = 0;
+
+	cmd.cmd = progdone;
+	cmd.cmd_len = sizeof(progdone);
+	ret = priv->write_commands(priv, &cmd, 1);
+	if (ret)
+		goto fail;
+	ret = machxo2_wait_until_not_busy(priv);
+	if (ret)
+		goto fail;
+
+	priv->get_status(priv, &status);
+	dump_status_reg(status);
+	if (!(status & MACHXO2_DONE)) {
+		machxo2_cleanup(mgr);
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	cmd.cmd = refresh;
+	cmd.cmd_len = sizeof(refresh);
+	cmd.delay_us = MACHXO2_REFRESH_USEC;
+
+	do {
+		ret = priv->write_commands(priv, &cmd, 1);
+		if (ret)
+			goto fail;
+
+		/* check refresh status */
+		priv->get_status(priv, &status);
+		dump_status_reg(status);
+		if (machxo2_status_done(status))
+			break;
+		if (++refreshloop == MACHXO2_MAX_REFRESH_LOOP) {
+			machxo2_cleanup(mgr);
+			ret = -EINVAL;
+			goto fail;
+		}
+	} while (1);
+
+	priv->get_status(priv, &status);
+	dump_status_reg(status);
+
+	return 0;
+fail:
+	dev_err(&mgr->dev, "Refresh failed.\n");
+
+	return ret;
+}
+
+static const struct fpga_manager_ops machxo2_ops = {
+	.state = machxo2_state,
+	.write_init = machxo2_write_init,
+	.write = machxo2_write,
+	.write_complete = machxo2_write_complete,
+};
+
+int machxo2_common_init(struct machxo2_common_priv *priv, struct device *dev)
+{
+	struct fpga_manager *mgr;
+
+	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
+				     &machxo2_ops, priv);
+
+	return PTR_ERR_OR_ZERO(mgr);
+}
diff --git a/drivers/fpga/machxo2-common.h b/drivers/fpga/machxo2-common.h
new file mode 100644
index 000000000000..908203644209
--- /dev/null
+++ b/drivers/fpga/machxo2-common.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0  */
+/*
+ * Copyright (C) 2018 Paolo Pisati <p.pisati@gmail.com>
+ * Copyright (C) 2021 Peter Jensen <pdj@bang-olufsen.dk>
+ * Copyright (C) 2022 Pengutronix, Johannes Zink <kernel@pengutronix.de>
+ */
+
+#ifndef __LINUX_FPGA_MGR_MACHXO2_COMMON_H
+#define __LINUX_FPGA_MGR_MACHXO2_COMMON_H
+
+#include <linux/types.h>
+
+/* MachXO2 Programming Guide - sysCONFIG Programming Commands */
+#define IDCODE_PUB              {0xe0, 0x00, 0x00, 0x00}
+#define ISC_ENABLE              {0xc6, 0x08, 0x00, 0x00}
+#define ISC_ERASE               {0x0e, 0x04, 0x00, 0x00}
+#define ISC_PROGRAMDONE         {0x5e, 0x00, 0x00, 0x00}
+#define LSC_INITADDRESS         {0x46, 0x00, 0x00, 0x00}
+#define LSC_PROGINCRNV          {0x70, 0x00, 0x00, 0x01}
+#define LSC_READ_STATUS         {0x3c, 0x00, 0x00, 0x00}
+#define LSC_REFRESH             {0x79, 0x00, 0x00, 0x00}
+
+struct machxo2_cmd {
+	u8 *cmd;
+	size_t cmd_len;
+	u16 delay_us;
+};
+
+struct machxo2_common_priv {
+	int (*write_commands)(struct machxo2_common_priv *priv,
+			     struct machxo2_cmd *cmds, size_t cmd_count);
+	int (*get_status)(struct machxo2_common_priv *priv, u32 *status);
+};
+
+int machxo2_common_init(struct machxo2_common_priv *priv, struct device *dev);
+
+#endif
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 5f1d6505f828..30965a3c293e 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -8,24 +8,10 @@
  * Copyright (C) 2018 Paolo Pisati <p.pisati@gmail.com>
  */
 
-#include <linux/delay.h>
-#include <linux/bitfield.h>
-#include <linux/fpga/fpga-mgr.h>
-#include <linux/gpio/consumer.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/spi/spi.h>
 #include <linux/container_of.h>
-
-/* MachXO2 Programming Guide - sysCONFIG Programming Commands */
-#define IDCODE_PUB		{0xe0, 0x00, 0x00, 0x00}
-#define ISC_ENABLE		{0xc6, 0x08, 0x00, 0x00}
-#define ISC_ERASE		{0x0e, 0x04, 0x00, 0x00}
-#define ISC_PROGRAMDONE		{0x5e, 0x00, 0x00, 0x00}
-#define LSC_INITADDRESS		{0x46, 0x00, 0x00, 0x00}
-#define LSC_PROGINCRNV		{0x70, 0x00, 0x00, 0x01}
-#define LSC_READ_STATUS		{0x3c, 0x00, 0x00, 0x00}
-#define LSC_REFRESH		{0x79, 0x00, 0x00, 0x00}
+#include "machxo2-common.h"
 
 /*
  * Max CCLK in Slave SPI mode according to 'MachXO2 Family Data
@@ -33,34 +19,6 @@
  */
 #define MACHXO2_MAX_SPEED		66000000
 
-#define MACHXO2_LOW_DELAY_USEC		5
-#define MACHXO2_HIGH_DELAY_USEC		200
-#define MACHXO2_REFRESH_USEC		4800
-#define MACHXO2_MAX_BUSY_LOOP		128
-#define MACHXO2_MAX_REFRESH_LOOP	16
-
-#define MACHXO2_PAGE_SIZE		16
-#define MACHXO2_BUF_SIZE		(MACHXO2_PAGE_SIZE + 4)
-
-/* Status register bits, errors and error mask */
-#define MACHXO2_BUSY		BIT(12)
-#define MACHXO2_DONE		BIT(8)
-#define MACHXO2_DVER		BIT(27)
-#define MACHXO2_ENAB		BIT(9)
-#define MACHXO2_ERR		GENMASK(25, 23)
-#define MACHXO2_ERR_ENOERR	0 /* no error */
-#define MACHXO2_ERR_EID		1
-#define MACHXO2_ERR_ECMD	2
-#define MACHXO2_ERR_ECRC	3
-#define MACHXO2_ERR_EPREAM	4 /* preamble error */
-#define MACHXO2_ERR_EABRT	5 /* abort error */
-#define MACHXO2_ERR_EOVERFL	6 /* overflow error */
-#define MACHXO2_ERR_ESDMEOF	7 /* SDM EOF */
-#define MACHXO2_FAIL		BIT(13)
-
-struct machxo2_common_priv {
-};
-
 struct machxo2_spi_priv {
 	struct machxo2_common_priv common;
 	struct spi_device *spi;
@@ -71,12 +29,7 @@ static inline struct machxo2_spi_priv *to_machxo2_spi_priv(struct machxo2_common
 	return container_of(priv, struct machxo2_spi_priv, common);
 }
 
-static inline u8 get_err(u32 status)
-{
-	return FIELD_GET(MACHXO2_ERR, status);
-}
-
-static int get_status(struct machxo2_common_priv *priv, u32 *status)
+static int machxo2_get_status_spi(struct machxo2_common_priv *priv, u32 *status)
 {
 	struct spi_device *spi = to_machxo2_spi_priv(priv)->spi;
 	struct spi_transfer transfers[2] = {};
@@ -98,52 +51,6 @@ static int get_status(struct machxo2_common_priv *priv, u32 *status)
 	return 0;
 }
 
-static const char *get_err_string(u8 err)
-{
-	switch (err) {
-	case MACHXO2_ERR_ENOERR:	return "No Error";
-	case MACHXO2_ERR_EID:		return "ID ERR";
-	case MACHXO2_ERR_ECMD:		return "CMD ERR";
-	case MACHXO2_ERR_ECRC:		return "CRC ERR";
-	case MACHXO2_ERR_EPREAM:	return "Preamble ERR";
-	case MACHXO2_ERR_EABRT:		return "Abort ERR";
-	case MACHXO2_ERR_EOVERFL:	return "Overflow ERR";
-	case MACHXO2_ERR_ESDMEOF:	return "SDM EOF";
-	}
-
-	return "Unknown";
-}
-
-static void dump_status_reg(u32 status)
-{
-	pr_debug("machxo2 status: 0x%08X - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
-		  status, !!FIELD_GET(MACHXO2_DONE, status), !!FIELD_GET(MACHXO2_ENAB, status),
-		  !!FIELD_GET(MACHXO2_BUSY, status), !!FIELD_GET(MACHXO2_FAIL, status),
-		  !!FIELD_GET(MACHXO2_DVER, status), get_err_string(get_err(status)));
-}
-
-static int machxo2_wait_until_not_busy(struct machxo2_common_priv *priv)
-{
-	u32 status;
-	int ret, loop = 0;
-
-	do {
-		ret = get_status(priv, &status);
-		if (ret)
-			return ret;
-		if (++loop >= MACHXO2_MAX_BUSY_LOOP)
-			return -EBUSY;
-	} while (status & MACHXO2_BUSY);
-
-	return 0;
-}
-
-struct machxo2_cmd {
-	u8 *cmd;
-	size_t cmd_len;
-	u16 delay_us;
-};
-
 static int machxo2_write_spi(struct machxo2_common_priv *priv,
 			     struct machxo2_cmd *cmds, size_t cmd_count)
 {
@@ -169,225 +76,10 @@ static int machxo2_write_spi(struct machxo2_common_priv *priv,
 	return ret;
 }
 
-static int machxo2_cleanup(struct fpga_manager *mgr)
-{
-	struct machxo2_common_priv *priv = mgr->priv;
-	u8 erase[] = ISC_ERASE;
-	u8 refresh[] = LSC_REFRESH;
-	struct machxo2_cmd cmd = {};
-	int ret;
-
-	cmd.cmd = erase;
-	cmd.cmd_len = sizeof(erase);
-	ret = machxo2_write_spi(priv, &cmd, 1);
-	if (ret)
-		goto fail;
-
-	ret = machxo2_wait_until_not_busy(priv);
-	if (ret)
-		goto fail;
-
-	cmd.cmd = refresh;
-	cmd.cmd_len = sizeof(refresh);
-	cmd.delay_us = MACHXO2_REFRESH_USEC;
-	ret = machxo2_write_spi(priv, &cmd, 1);
-	if (ret)
-		goto fail;
-
-	return 0;
-fail:
-	dev_err(&mgr->dev, "Cleanup failed\n");
-
-	return ret;
-}
-
-static bool machxo2_status_done(unsigned long status)
-{
-	return (((status & (MACHXO2_BUSY | MACHXO2_DONE)) == MACHXO2_DONE) &&
-		get_err(status) == MACHXO2_ERR_ENOERR);
-}
-
-static enum fpga_mgr_states machxo2_spi_state(struct fpga_manager *mgr)
-{
-	struct machxo2_common_priv *priv = mgr->priv;
-	u32 status;
-
-	get_status(priv, &status);
-	if (machxo2_status_done(status))
-		return FPGA_MGR_STATE_OPERATING;
-
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
-static int machxo2_write_init(struct fpga_manager *mgr,
-			      struct fpga_image_info *info,
-			      const char *buf, size_t count)
-{
-	struct machxo2_common_priv *priv = mgr->priv;
-	u8 enable[] = ISC_ENABLE;
-	u8 erase[] = ISC_ERASE;
-	u8 initaddr[] = LSC_INITADDRESS;
-	struct machxo2_cmd cmd[2] = {};
-	u32 status;
-	int ret;
-
-	if ((info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
-		dev_err(&mgr->dev,
-			"Partial reconfiguration is not supported\n");
-		return -ENOTSUPP;
-	}
-
-	get_status(priv, &status);
-	dump_status_reg(status);
-
-	cmd[0].cmd = enable;
-	cmd[0].cmd_len = sizeof(enable);
-	cmd[0].delay_us = MACHXO2_LOW_DELAY_USEC;
-
-	cmd[1].cmd = erase;
-	cmd[1].cmd_len = sizeof(erase);
-	ret = machxo2_write_spi(spi, cmd, ARRAY_SIZE(cmd));
-
-	if (ret)
-		goto fail;
-
-	ret = machxo2_wait_until_not_busy(priv);
-	if (ret)
-		goto fail;
-
-	get_status(priv, &status);
-	if (status & MACHXO2_FAIL) {
-		ret = -EINVAL;
-		goto fail;
-	}
-	dump_status_reg(status);
-
-	cmd[0].cmd = initaddr;
-	cmd[0].cmd_len = sizeof(initaddr);
-	ret = machxo2_write_spi(priv, &cmd[0], 1);
-	if (ret)
-		goto fail;
-
-	get_status(priv, &status);
-	dump_status_reg(status);
-
-	return 0;
-fail:
-	dev_err(&mgr->dev, "Error during FPGA init.\n");
-
-	return ret;
-}
-
-static int machxo2_write(struct fpga_manager *mgr, const char *buf,
-			 size_t count)
-{
-	struct machxo2_common_priv *priv = mgr->priv;
-	u8 progincr[] = LSC_PROGINCRNV;
-	u8 payload[MACHXO2_BUF_SIZE];
-	struct machxo2_cmd cmd = {};
-	u32 status;
-	int i, ret;
-
-	if (count % MACHXO2_PAGE_SIZE != 0) {
-		dev_err(&mgr->dev, "Malformed payload.\n");
-		return -EINVAL;
-	}
-	get_status(priv, &status);
-	dump_status_reg(status);
-
-	cmd.cmd = payload;
-	cmd.cmd_len = MACHXO2_BUF_SIZE;
-	cmd.delay_us = MACHXO2_HIGH_DELAY_USEC;
-
-	memcpy(payload, &progincr, sizeof(progincr));
-	for (i = 0; i < count; i += MACHXO2_PAGE_SIZE) {
-		memcpy(&payload[sizeof(progincr)], &buf[i], MACHXO2_PAGE_SIZE);
-
-		cmd.cmd = payload;
-		cmd.cmd_len = MACHXO2_BUF_SIZE;
-		cmd.delay_us = MACHXO2_HIGH_DELAY_USEC;
-		ret = machxo2_write_spi(priv, &cmd, 1);
-		if (ret) {
-			dev_err(&mgr->dev, "Error loading the bitstream.\n");
-			return ret;
-		}
-	}
-	get_status(priv, &status);
-	dump_status_reg(status);
-
-	return 0;
-}
-
-static int machxo2_write_complete(struct fpga_manager *mgr,
-				  struct fpga_image_info *info)
-{
-	struct machxo2_common_priv *priv = mgr->priv;
-	struct machxo2_cmd cmd = {};
-	u8 progdone[] = ISC_PROGRAMDONE;
-	u8 refresh[] = LSC_REFRESH;
-	u32 status;
-	int ret, refreshloop = 0;
-
-	cmd.cmd = progdone;
-	cmd.cmd_len = sizeof(progdone);
-	ret = machxo2_write_spi(priv, &cmd, 1);
-	if (ret)
-		goto fail;
-	ret = machxo2_wait_until_not_busy(priv);
-	if (ret)
-		goto fail;
-
-	get_status(priv, &status);
-	dump_status_reg(status);
-	if (!(status & MACHXO2_DONE)) {
-		machxo2_cleanup(mgr);
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	cmd.cmd = refresh;
-	cmd.cmd_len = sizeof(refresh);
-	cmd.delay_us = MACHXO2_REFRESH_USEC;
-
-	do {
-		ret = machxo2_write_spi(priv, &cmd, 1);
-		if (ret)
-			goto fail;
-
-		/* check refresh status */
-		get_status(priv, &status);
-		dump_status_reg(status);
-		if (machxo2_status_done(status))
-			break;
-		if (++refreshloop == MACHXO2_MAX_REFRESH_LOOP) {
-			machxo2_cleanup(mgr);
-			ret = -EINVAL;
-			goto fail;
-		}
-	} while (1);
-
-	get_status(priv, &status);
-	dump_status_reg(status);
-
-	return 0;
-fail:
-	dev_err(&mgr->dev, "Refresh failed.\n");
-
-	return ret;
-}
-
-static const struct fpga_manager_ops machxo2_ops = {
-	.state = machxo2_spi_state,
-	.write_init = machxo2_write_init,
-	.write = machxo2_write,
-	.write_complete = machxo2_write_complete,
-};
-
 static int machxo2_spi_probe(struct spi_device *spi)
 {
 	struct machxo2_spi_priv *priv;
 	struct device *dev = &spi->dev;
-	struct fpga_manager *mgr;
 
 	if (spi->max_speed_hz > MACHXO2_MAX_SPEED) {
 		dev_err(dev, "Speed is too high\n");
@@ -399,10 +91,10 @@ static int machxo2_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	priv->spi = spi;
+	priv->common.write_commands = machxo2_write_spi;
+	priv->common.get_status = machxo2_get_status_spi;
 
-	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
-				     &machxo2_ops, &priv->common);
-	return PTR_ERR_OR_ZERO(mgr);
+	return machxo2_common_init(&(priv->common), dev);
 }
 
 #ifdef CONFIG_OF
-- 
2.30.2

