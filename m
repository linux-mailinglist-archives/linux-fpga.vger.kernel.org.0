Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46935A5FFA
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiH3Jzi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 05:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiH3Jza (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 05:55:30 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA171A826;
        Tue, 30 Aug 2022 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=DWCYqym6pWjyj36zclXMIjHzW+EiEHgtwx887LtbRmo=;
        b=G5DYS2QLqezPz2vGnlltgkAn0rr6Z+02oDWKzhsCccpdBa6lPN7JH5eUJ/afl9bPNv3WTM9jFsiY0
         XbJNilsiWeTT4HDoHveUYuwScVCibenl1ImDoA01Zlbp3XR+2uSnDwRj+WZufL7Bl5vCYYdOryQUb0
         ijDQyIj6Wqkvt6ik4HgMVXQJYA2tFbgJgghMyzHt5uRPeugf5tBfEA+9AmrgWw34VFMjMdC8iTnhSJ
         L7U40f3mf2mYGGKGQl2Gl4G2aF/EEQSqheqEVqJdqIv3PWNrOMw9aXV0l4rg3LvoRnVzNdRPLn6iGo
         EGEj8x8dVXMaHo61ZOC0MGyf5WV/3Hg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000014,0.066026)], BW: [Enabled, t: (0.000017,0.000001)], RTDA: [Enabled, t: (0.086269), Hit: No, Details: v2.41.0; Id: 15.52k59d.1gbn2qdkm.pu; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 30 Aug 2022 12:55:13 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        system@metrotek.ru
Subject: [PATCH v9 1/2] fpga: lattice-sysconfig-spi: add Lattice sysCONFIG FPGA manager
Date:   Tue, 30 Aug 2022 12:54:04 +0300
Message-Id: <20220830095405.31609-2-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830095405.31609-1-i.bornyakov@metrotek.ru>
References: <20220830095405.31609-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support to the FPGA manager for programming Lattice ECP5 and MachXO2
FPGAs over slave SPI sysCONFIG interface.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/Kconfig         |   7 +
 drivers/fpga/Makefile        |   3 +
 drivers/fpga/sysconfig-spi.c | 216 +++++++++++++++++
 drivers/fpga/sysconfig.c     | 433 +++++++++++++++++++++++++++++++++++
 drivers/fpga/sysconfig.h     |  67 ++++++
 5 files changed, 726 insertions(+)
 create mode 100644 drivers/fpga/sysconfig-spi.c
 create mode 100644 drivers/fpga/sysconfig.c
 create mode 100644 drivers/fpga/sysconfig.h

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 6c416955da53..991d9d976dca 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -263,4 +263,11 @@ config FPGA_MGR_MICROCHIP_SPI
 	  programming over slave SPI interface with .dat formatted
 	  bitstream image.
 
+config FPGA_MGR_LATTICE_SPI
+	tristate "Lattice sysCONFIG SPI FPGA manager"
+	depends on SPI
+	help
+	  FPGA manager driver support for Lattice FPGAs programming over slave
+	  SPI sysCONFIG interface.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 42ae8b58abce..70e5f58d0c10 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -20,9 +20,12 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
 obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
+obj-$(CONFIG_FPGA_MGR_LATTICE_SPI)	+= lattice-sysconfig-spi.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
 
+lattice-sysconfig-spi-objs		:= sysconfig-spi.o sysconfig.o
+
 # FPGA Secure Update Drivers
 obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
 
diff --git a/drivers/fpga/sysconfig-spi.c b/drivers/fpga/sysconfig-spi.c
new file mode 100644
index 000000000000..449f9f623762
--- /dev/null
+++ b/drivers/fpga/sysconfig-spi.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lattice FPGA programming over slave SPI sysCONFIG interface.
+ */
+
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+
+#include "sysconfig.h"
+
+static int sysconfig_spi_transfer(struct sysconfig_priv *priv,
+				  const void *tx_buf, size_t tx_len,
+				  void *rx_buf, size_t rx_len)
+{
+	if (!rx_buf)
+		return spi_write(priv->spi, tx_buf, tx_len);
+
+	return spi_write_then_read(priv->spi, tx_buf, tx_len, rx_buf, rx_len);
+}
+
+int sysconfig_lsc_burst_init(struct sysconfig_priv *priv)
+{
+	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
+	struct spi_device *spi = priv->spi;
+	struct spi_transfer xfer = {
+		.tx_buf = lsc_bitstream_burst,
+		.len = sizeof(lsc_bitstream_burst),
+		.cs_change = 1,
+	};
+	struct spi_message msg;
+	int ret;
+
+	if (!spi)
+		return -EOPNOTSUPP;
+
+	spi_message_init_with_transfers(&msg, &xfer, 1);
+
+	/*
+	 * Lock SPI bus for exclusive usage until FPGA programming is done.
+	 * SPI bus will be released in sysconfig_lsc_burst_complete().
+	 */
+	spi_bus_lock(spi->controller);
+
+	ret = spi_sync_locked(spi, &msg);
+	if (ret)
+		spi_bus_unlock(spi->controller);
+
+	return ret;
+}
+
+int sysconfig_lsc_burst_complete(struct sysconfig_priv *priv)
+{
+	struct spi_device *spi = priv->spi;
+	int ret;
+
+	if (!spi)
+		return -EOPNOTSUPP;
+
+	/* Bitstream burst write is done, release SPI bus */
+	spi_bus_unlock(spi->controller);
+
+	/* Toggle CS and wait for bitstream write to finish */
+	ret = priv->sysconfig_transfer(priv, NULL, 0, NULL, 0);
+	if (!ret)
+		ret = sysconfig_poll_busy(priv);
+
+	return ret;
+}
+
+static int sysconfig_bitstream_burst_write(struct sysconfig_priv *priv,
+					   const char *buf, size_t count)
+{
+	struct spi_device *spi = priv->spi;
+	struct spi_transfer xfer = {
+		.tx_buf = buf,
+		.len = count,
+		.cs_change = 1,
+	};
+	struct spi_message msg;
+	int ret;
+
+	spi_message_init_with_transfers(&msg, &xfer, 1);
+	ret = spi_sync_locked(spi, &msg);
+	if (ret)
+		spi_bus_unlock(spi->controller);
+
+	return ret;
+}
+
+static int sysconfig_bitstream_paged_write(struct sysconfig_priv *priv,
+					   const char *buf, size_t count)
+{
+	const u8 lsc_progincr[] = SYSCONFIG_LSC_PROG_INCR_NV;
+	struct spi_device *spi = priv->spi;
+	struct spi_transfer xfers[2] = {
+		{
+			.tx_buf = lsc_progincr,
+			.len = sizeof(lsc_progincr),
+		}, {
+			.len = SYSCONFIG_PAGE_SIZE,
+		},
+	};
+	size_t i;
+	int ret;
+
+	if (count % SYSCONFIG_PAGE_SIZE)
+		return -EINVAL;
+
+	for (i = 0; i < count; i += SYSCONFIG_PAGE_SIZE) {
+		xfers[1].tx_buf = buf + i;
+
+		ret = spi_sync_transfer(spi, xfers, 2);
+		if (!ret)
+			ret = sysconfig_poll_busy(priv);
+
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int sysconfig_ops_spi_write(struct fpga_manager *mgr, const char *buf,
+				   size_t count)
+{
+	const struct sysconfig_fpga_priv *fpga_priv;
+	struct sysconfig_priv *priv;
+
+	priv = mgr->priv;
+	fpga_priv = priv->fpga_priv;
+
+	if (fpga_priv->spi_burst_write)
+		return sysconfig_bitstream_burst_write(priv, buf, count);
+
+	return sysconfig_bitstream_paged_write(priv, buf, count);
+}
+
+static int sysconfig_spi_probe(struct spi_device *spi)
+{
+	const struct sysconfig_fpga_priv *fpga_priv;
+	const struct spi_device_id *dev_id;
+	struct device *dev = &spi->dev;
+	struct sysconfig_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	fpga_priv = of_device_get_match_data(dev);
+	if (!fpga_priv) {
+		dev_id = spi_get_device_id(spi);
+		if (!dev_id)
+			return -ENODEV;
+
+		fpga_priv = (const struct sysconfig_fpga_priv *)dev_id->driver_data;
+	}
+
+	if (!fpga_priv)
+		return -EINVAL;
+
+	if (spi->max_speed_hz > fpga_priv->spi_max_speed_hz) {
+		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
+			spi->max_speed_hz, fpga_priv->spi_max_speed_hz);
+		return -EINVAL;
+	}
+
+	priv->dev = dev;
+	priv->spi = spi;
+	priv->fpga_priv = fpga_priv;
+	priv->sysconfig_transfer = sysconfig_spi_transfer;
+	priv->sysconfig_fpga_mgr_ops.state = sysconfig_ops_state;
+	priv->sysconfig_fpga_mgr_ops.write_init = sysconfig_ops_write_init;
+	priv->sysconfig_fpga_mgr_ops.write = sysconfig_ops_spi_write;
+	priv->sysconfig_fpga_mgr_ops.write_complete = sysconfig_ops_write_complete;
+
+	return sysconfig_probe(priv);
+}
+
+static const struct spi_device_id sysconfig_spi_ids[] = {
+	{
+		.name = "ecp5-fpga-mgr",
+		.driver_data = (kernel_ulong_t)&ecp5_data,
+	}, {
+		.name = "machxo2-fpga-mgr",
+		.driver_data = (kernel_ulong_t)&machxo2_data,
+	}, {},
+};
+MODULE_DEVICE_TABLE(spi, sysconfig_spi_ids);
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id sysconfig_of_ids[] = {
+	{
+		.compatible = "lattice,ecp5-fpga-mgr",
+		.data = &ecp5_data,
+	}, {
+		.compatible = "lattice,machxo2-fpga-mgr",
+		.data = &machxo2_data,
+	}, {},
+};
+MODULE_DEVICE_TABLE(of, sysconfig_of_ids);
+#endif /* IS_ENABLED(CONFIG_OF) */
+
+static struct spi_driver lattice_sysconfig_driver = {
+	.probe = sysconfig_spi_probe,
+	.id_table = sysconfig_spi_ids,
+	.driver = {
+		.name = "lattice_sysconfig_spi_fpga_mgr",
+		.of_match_table = of_match_ptr(sysconfig_of_ids),
+	},
+};
+
+module_spi_driver(lattice_sysconfig_driver);
+
+MODULE_DESCRIPTION("Lattice sysCONFIG Slave SPI FPGA Manager");
+MODULE_LICENSE("GPL");
diff --git a/drivers/fpga/sysconfig.c b/drivers/fpga/sysconfig.c
new file mode 100644
index 000000000000..122937eb89a3
--- /dev/null
+++ b/drivers/fpga/sysconfig.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Lattice FPGA sysCONFIG interface functions independent of port type.
+ */
+
+#include <linux/delay.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+
+#include "sysconfig.h"
+
+const struct sysconfig_fpga_priv ecp5_data = {
+	.spi_max_speed_hz = 60000000,
+	.isc_enable_operand = 0x00,
+	.spi_burst_write = true,
+	.internal_flash = false,
+};
+
+const struct sysconfig_fpga_priv machxo2_data = {
+	.spi_max_speed_hz = 66000000,
+	.isc_enable_operand = 0x08,
+	.spi_burst_write = false,
+	.internal_flash = true,
+};
+
+static int sysconfig_read_busy(struct sysconfig_priv *priv)
+{
+	const u8 lsc_check_busy[] = SYSCONFIG_LSC_CHECK_BUSY;
+	u8 busy;
+	int ret;
+
+	ret = priv->sysconfig_transfer(priv, lsc_check_busy, sizeof(lsc_check_busy),
+				       &busy, sizeof(busy));
+
+	return ret ? : busy;
+}
+
+int sysconfig_poll_busy(struct sysconfig_priv *priv)
+{
+	size_t retries = SYSCONFIG_POLL_RETRIES;
+	int ret;
+
+	while (retries--) {
+		ret = sysconfig_read_busy(priv);
+		if (ret <= 0)
+			return ret;
+
+		usleep_range(SYSCONFIG_POLL_INTERVAL_US,
+			     SYSCONFIG_POLL_INTERVAL_US * 2);
+	}
+
+	return -EBUSY;
+}
+
+static int sysconfig_read_status(struct sysconfig_priv *priv, u32 *status)
+{
+	const u8 lsc_read_status[] = SYSCONFIG_LSC_READ_STATUS;
+	__be32 device_status;
+	int ret;
+
+	ret = priv->sysconfig_transfer(priv, lsc_read_status,
+				       sizeof(lsc_read_status),
+				       &device_status, sizeof(device_status));
+	if (ret)
+		return ret;
+
+	*status = be32_to_cpu(device_status);
+
+	return 0;
+}
+
+static int sysconfig_poll_status(struct sysconfig_priv *priv, u32 *status)
+{
+	int ret = sysconfig_poll_busy(priv);
+
+	if (ret)
+		return ret;
+
+	return sysconfig_read_status(priv, status);
+}
+
+static int sysconfig_poll_gpio(struct gpio_desc *gpio, bool is_active)
+{
+	size_t retries = SYSCONFIG_POLL_RETRIES;
+	int value;
+
+	while (retries--) {
+		value = gpiod_get_value(gpio);
+		if (value < 0)
+			return value;
+
+		if ((is_active && value) || (!is_active && !value))
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int sysconfig_gpio_refresh(struct sysconfig_priv *priv)
+{
+	struct gpio_desc *program = priv->program;
+	struct gpio_desc *init = priv->init;
+	struct gpio_desc *done = priv->done;
+	int ret;
+
+	/* Enter init mode */
+	gpiod_set_value(program, 1);
+
+	ret = sysconfig_poll_gpio(init, true);
+	if (!ret)
+		ret = sysconfig_poll_gpio(done, false);
+
+	if (ret)
+		return ret;
+
+	/* Enter program mode */
+	gpiod_set_value(program, 0);
+
+	return sysconfig_poll_gpio(init, false);
+}
+
+static int sysconfig_lsc_refresh(struct sysconfig_priv *priv)
+{
+	static const u8 lsc_refresh[] = SYSCONFIG_LSC_REFRESH;
+	int ret;
+
+	ret = priv->sysconfig_transfer(priv, lsc_refresh, sizeof(lsc_refresh),
+				       NULL, 0);
+	if (ret)
+		return ret;
+
+	usleep_range(4000, 8000);
+
+	return 0;
+}
+
+static int sysconfig_refresh(struct sysconfig_priv *priv)
+{
+	struct gpio_desc *program = priv->program;
+	struct gpio_desc *init = priv->init;
+	struct gpio_desc *done = priv->done;
+
+	if (program && init && done)
+		return sysconfig_gpio_refresh(priv);
+
+	return sysconfig_lsc_refresh(priv);
+}
+
+static int sysconfig_isc_enable(struct sysconfig_priv *priv)
+{
+	const struct sysconfig_fpga_priv *fpga_priv = priv->fpga_priv;
+	u8 isc_enable[] = SYSCONFIG_ISC_ENABLE;
+	u32 status;
+	int ret;
+
+	isc_enable[1] = fpga_priv->isc_enable_operand;
+
+	ret = priv->sysconfig_transfer(priv, isc_enable, sizeof(isc_enable),
+				       NULL, 0);
+	if (ret)
+		return ret;
+
+	ret = sysconfig_poll_status(priv, &status);
+	if (ret || (status & SYSCONFIG_STATUS_FAIL))
+		return ret ? : -EFAULT;
+
+	return 0;
+}
+
+static int sysconfig_isc_erase(struct sysconfig_priv *priv)
+{
+	const struct sysconfig_fpga_priv *fpga_priv = priv->fpga_priv;
+	u8 isc_erase[] = SYSCONFIG_ISC_ERASE;
+	u32 status;
+	int ret;
+
+	isc_erase[1] = SYSCONFIG_ISC_ERASE_SRAM;
+
+	if (fpga_priv->internal_flash)
+		isc_erase[1] |= SYSCONFIG_ISC_ERASE_FLASH;
+
+	ret = priv->sysconfig_transfer(priv, isc_erase, sizeof(isc_erase),
+				       NULL, 0);
+	if (ret)
+		return ret;
+
+	ret = sysconfig_poll_status(priv, &status);
+	if (ret || (status & SYSCONFIG_STATUS_FAIL))
+		return ret ? : -EFAULT;
+
+	return 0;
+}
+
+static int sysconfig_isc_init(struct sysconfig_priv *priv)
+{
+	int ret = sysconfig_isc_enable(priv);
+
+	if (ret)
+		return ret;
+
+	return sysconfig_isc_erase(priv);
+}
+
+static int sysconfig_lsc_init_addr(struct sysconfig_priv *priv)
+{
+	const u8 lsc_init_addr[] = SYSCONFIG_LSC_INIT_ADDR;
+
+	return priv->sysconfig_transfer(priv, lsc_init_addr,
+					sizeof(lsc_init_addr), NULL, 0);
+}
+
+static int sysconfig_isc_prog_done(struct sysconfig_priv *priv)
+{
+	const u8 isc_prog_done[] = SYSCONFIG_ISC_PROGRAM_DONE;
+	u32 status;
+	int ret;
+
+	ret = priv->sysconfig_transfer(priv, isc_prog_done,
+				       sizeof(isc_prog_done), NULL, 0);
+	if (ret)
+		return ret;
+
+	ret = sysconfig_poll_status(priv, &status);
+	if (ret)
+		return ret;
+
+	if (status & SYSCONFIG_STATUS_DONE)
+		return 0;
+
+	return -EFAULT;
+}
+
+static int sysconfig_isc_disable(struct sysconfig_priv *priv)
+{
+	const u8 isc_disable[] = SYSCONFIG_ISC_DISABLE;
+
+	return priv->sysconfig_transfer(priv, isc_disable, sizeof(isc_disable),
+					NULL, 0);
+}
+
+enum fpga_mgr_states sysconfig_ops_state(struct fpga_manager *mgr)
+{
+	struct sysconfig_priv *priv = mgr->priv;
+	struct gpio_desc *done = priv->done;
+	u32 status;
+	int ret;
+
+	if (done && (gpiod_get_value(done) > 0))
+		return FPGA_MGR_STATE_OPERATING;
+
+	ret = sysconfig_read_status(priv, &status);
+	if (!ret && (status & SYSCONFIG_STATUS_DONE))
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+int sysconfig_ops_write_init(struct fpga_manager *mgr,
+			     struct fpga_image_info *info,
+			     const char *buf, size_t count)
+{
+	const struct sysconfig_fpga_priv *fpga_priv;
+	struct sysconfig_priv *priv;
+	struct device *dev;
+	int ret;
+
+	dev = &mgr->dev;
+	priv = mgr->priv;
+	fpga_priv = priv->fpga_priv;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(dev, "Partial reconfiguration is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!fpga_priv->internal_flash) {
+		/* Write directly to SRAM */
+		ret = sysconfig_refresh(priv);
+		if (ret) {
+			dev_err(dev, "Failed to go to program mode\n");
+			return ret;
+		}
+	}
+
+	/* Enter ISC mode */
+	ret = sysconfig_isc_init(priv);
+	if (ret) {
+		dev_err(dev, "Failed to go to ISC mode\n");
+		return ret;
+	}
+
+	/* Initialize the Address Shift Register */
+	ret = sysconfig_lsc_init_addr(priv);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the Address Shift Register\n");
+		return ret;
+	}
+
+	if (fpga_priv->spi_burst_write) {
+		/* Prepare for SPI burst write */
+		ret = sysconfig_lsc_burst_init(priv);
+		if (ret)
+			dev_err(dev,
+				"Failed to prepare for bitstream burst write\n");
+	}
+
+	return ret;
+}
+
+static void sysconfig_cleanup(struct sysconfig_priv *priv)
+{
+	sysconfig_isc_erase(priv);
+	sysconfig_refresh(priv);
+}
+
+static int sysconfig_isc_finish(struct sysconfig_priv *priv)
+{
+	const struct sysconfig_fpga_priv *fpga_priv = priv->fpga_priv;
+	int ret, retries = SYSCONFIG_REFRESH_RETRIES;
+	struct gpio_desc *done_gpio = priv->done;
+	u32 status;
+
+	if (done_gpio) {
+		ret = sysconfig_isc_disable(priv);
+		if (ret)
+			return ret;
+
+		return sysconfig_poll_gpio(done_gpio, true);
+	}
+
+	while (retries--) {
+		ret = sysconfig_poll_status(priv, &status);
+		if (ret)
+			break;
+
+		if ((status & SYSCONFIG_STATUS_DONE) &&
+		    !(status & SYSCONFIG_STATUS_BUSY) &&
+		    !(status & SYSCONFIG_STATUS_ERR)) {
+			return sysconfig_isc_disable(priv);
+		}
+
+		if (fpga_priv->internal_flash) {
+			ret = sysconfig_refresh(priv);
+			if (ret)
+				break;
+		}
+	}
+
+	return -EFAULT;
+}
+
+int sysconfig_ops_write_complete(struct fpga_manager *mgr,
+				 struct fpga_image_info *info)
+{
+	const struct sysconfig_fpga_priv *fpga_priv;
+	struct sysconfig_priv *priv;
+	struct device *dev;
+	int ret;
+
+	dev = &mgr->dev;
+	priv = mgr->priv;
+	fpga_priv = priv->fpga_priv;
+
+	if (fpga_priv->spi_burst_write) {
+		ret = sysconfig_lsc_burst_complete(priv);
+		if (ret) {
+			dev_err(dev,
+				"Error while waiting bitstream write to finish\n");
+			goto fail;
+		}
+	}
+
+	if (fpga_priv->internal_flash) {
+		ret = sysconfig_isc_prog_done(priv);
+		if (!ret)
+			ret = sysconfig_refresh(priv);
+
+		if (ret) {
+			dev_err(dev, "Failed to enable Self-Download Mode\n");
+			goto fail;
+		}
+	}
+
+	ret = sysconfig_isc_finish(priv);
+
+fail:
+	if (ret)
+		sysconfig_cleanup(priv);
+
+	return ret;
+}
+
+int sysconfig_probe(struct sysconfig_priv *priv)
+{
+	struct gpio_desc *program, *init, *done;
+	struct device *dev = priv->dev;
+	struct fpga_manager *mgr;
+	int ret;
+
+	if (!dev)
+		return -ENODEV;
+
+	program = devm_gpiod_get_optional(dev, "program", GPIOD_OUT_LOW);
+	if (IS_ERR(program)) {
+		ret = PTR_ERR(program);
+		dev_err(dev, "Failed to get PROGRAM GPIO: %d\n", ret);
+		return ret;
+	}
+
+	init = devm_gpiod_get_optional(dev, "init", GPIOD_IN);
+	if (IS_ERR(init)) {
+		ret = PTR_ERR(init);
+		dev_err(dev, "Failed to get INIT GPIO: %d\n", ret);
+		return ret;
+	}
+
+	done = devm_gpiod_get_optional(dev, "done", GPIOD_IN);
+	if (IS_ERR(done)) {
+		ret = PTR_ERR(done);
+		dev_err(dev, "Failed to get DONE GPIO: %d\n", ret);
+		return ret;
+	}
+
+	priv->program = program;
+	priv->init = init;
+	priv->done = done;
+
+	mgr = devm_fpga_mgr_register(dev, "Lattice sysCONFIG FPGA Manager",
+				     &priv->sysconfig_fpga_mgr_ops, priv);
+
+	return PTR_ERR_OR_ZERO(mgr);
+}
diff --git a/drivers/fpga/sysconfig.h b/drivers/fpga/sysconfig.h
new file mode 100644
index 000000000000..997c24c35975
--- /dev/null
+++ b/drivers/fpga/sysconfig.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef	__LATTICE_SYSCONFIG_H
+#define	__LATTICE_SYSCONFIG_H
+
+#define	SYSCONFIG_ISC_ENABLE		{0xC6, 0x00, 0x00, 0x00}
+#define	SYSCONFIG_ISC_DISABLE		{0x26, 0x00, 0x00, 0x00}
+#define	SYSCONFIG_ISC_ERASE		{0x0E, 0x00, 0x00, 0x00}
+#define	SYSCONFIG_ISC_PROGRAM_DONE	{0x5E, 0x00, 0x00, 0x00}
+#define	SYSCONFIG_LSC_READ_STATUS	{0x3C, 0x00, 0x00, 0x00}
+#define	SYSCONFIG_LSC_CHECK_BUSY	{0xF0, 0x00, 0x00, 0x00}
+#define	SYSCONFIG_LSC_REFRESH		{0x79, 0x00, 0x00, 0x00}
+#define	SYSCONFIG_LSC_INIT_ADDR		{0x46, 0x00, 0x00, 0x00}
+#define	SYSCONFIG_LSC_BITSTREAM_BURST	{0x7a, 0x00, 0x00, 0x00}
+#define	SYSCONFIG_LSC_PROG_INCR_NV	{0x70, 0x00, 0x00, 0x01}
+
+#define	SYSCONFIG_ISC_ERASE_SRAM	BIT(0)
+#define	SYSCONFIG_ISC_ERASE_FLASH	BIT(2)
+
+#define	SYSCONFIG_STATUS_DONE		BIT(8)
+#define	SYSCONFIG_STATUS_BUSY		BIT(12)
+#define	SYSCONFIG_STATUS_FAIL		BIT(13)
+#define	SYSCONFIG_STATUS_ERR		(BIT(23) | BIT(24) | BIT(25))
+
+#define	SYSCONFIG_REFRESH_RETRIES	16
+#define	SYSCONFIG_POLL_RETRIES		1000000
+#define	SYSCONFIG_POLL_INTERVAL_US	30
+
+#define	SYSCONFIG_PAGE_SIZE		16
+
+struct sysconfig_fpga_priv {
+	u32 spi_max_speed_hz;
+	u8 isc_enable_operand;
+	bool spi_burst_write;
+	bool internal_flash;
+};
+
+extern const struct sysconfig_fpga_priv ecp5_data;
+extern const struct sysconfig_fpga_priv machxo2_data;
+
+struct sysconfig_priv {
+	struct fpga_manager_ops sysconfig_fpga_mgr_ops;
+	const struct sysconfig_fpga_priv *fpga_priv;
+	struct gpio_desc *program;
+	struct gpio_desc *init;
+	struct gpio_desc *done;
+	struct spi_device *spi;
+	struct device *dev;
+	int (*sysconfig_transfer)(struct sysconfig_priv *priv,
+				  const void *tx_buf, size_t tx_len,
+				  void *rx_buf, size_t rx_len);
+};
+
+int sysconfig_poll_busy(struct sysconfig_priv *priv);
+int sysconfig_lsc_burst_init(struct sysconfig_priv *priv);
+int sysconfig_lsc_burst_complete(struct sysconfig_priv *priv);
+
+enum fpga_mgr_states sysconfig_ops_state(struct fpga_manager *mgr);
+int sysconfig_ops_write_init(struct fpga_manager *mgr,
+			     struct fpga_image_info *info,
+			     const char *buf, size_t count);
+int sysconfig_ops_write_complete(struct fpga_manager *mgr,
+				 struct fpga_image_info *info);
+
+int sysconfig_probe(struct sysconfig_priv *priv);
+
+#endif /* __LATTICE_SYSCONFIG_H */
-- 
2.37.2


