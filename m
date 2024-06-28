Return-Path: <linux-fpga+bounces-564-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4091C28D
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAED71F21F7A
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B871C68B3;
	Fri, 28 Jun 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBjXhDzd"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20831C6893;
	Fri, 28 Jun 2024 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588257; cv=none; b=VI3mGngzBu93yq14AZMGwfPjzTNBVDEkREllAs0rU9hnHllYUiFvJxAnkfCcrN+tgdE9s6yuap01eSiYBLupUaLwc9UlP3tVtRSxsTC1+9HjwtLsneS9M3WPo2UvW1h/aAMHNd4piSsKVR6GWBy9VktL9MCv9L9/RyNLfbn0fPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588257; c=relaxed/simple;
	bh=wv/tPHnVFDFxvkffOh2TWFigIzr8JgFTiRk6zfmBUEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rrfD667xhIcNoksalaebRUoGTBwl5xBZXLoICLeH9/Fo6if7IOyUYUwYOdv6DZR1B5L+o5VF66BYMi8xdfP+hLCMiVxqEpxHeTDAp2EOnu9GcrXhB5RRRfvLsX3MmociMx2xgX1oNpcvmC9Fg+d5nTSExC4swUnM/fUHknwnDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBjXhDzd; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so1439849e87.1;
        Fri, 28 Jun 2024 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719588254; x=1720193054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7rugaJsrGdIm1Ix/ztb8hKsPqYUFKNp5tBPNxYhbtY=;
        b=fBjXhDzdN52RlMqO0w+3HKoMMQpOVWZTliTsm0UaWVJFqCjNPAiqBw5xs8nSSgOUPX
         b2ptuenyEWsPWV7LgbRrVP9qGgd6Ozw3/MWKtYedZI1/fe7J6a1CMYtlHDp9V0HeD3Jn
         dKfk4jnwEPdZVWJSyATCYlFlhvVIdkvSqGWgR++ZMGV8kzhv/CPS4S/t8SwwDrvAmhKp
         TMw6bAR7MDoCi0WaO6wFP9KcByOfpom9WNfKpyRDsJkTIHm/2dKPtcwvRC3pGSsIXvRt
         vcMqHFlmhxC0cFeH5gx1R7hHeXJPnKo5ZL8qYREY4spS6HJDCO5x9ny2illP0uSnh5wl
         Pd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588254; x=1720193054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7rugaJsrGdIm1Ix/ztb8hKsPqYUFKNp5tBPNxYhbtY=;
        b=MUVFmMgxlgZ2ggyhYnj1MLMYTgExzLm/V7O056W9VSsSA0LBfwT/AlpRV8lI/aDlqX
         QVc7Uff3bMxWpLUbxqxj1dZ8r477jNTUAnrxZN8Ku3iQfqEvxsDOG6bczNnXEORgW0OY
         E4ft6lVJAzDOj7JCYVyCivqIo+vST83OoOqtR55vG/iHtYTcSEGZz15IcxhesVEMsrfK
         aH9oU+HXFytnL5cBAxN1vURhakzSYHflaKpm3Hkt9wHkcalWZrBzW1CZK6+8IKwMmFGh
         BAJx1YkQioMVqZ/dSKHbnXehBsBMMDeToxNim7/qGYa7mW6pUOR6ryektvUanPdzpZou
         arcw==
X-Forwarded-Encrypted: i=1; AJvYcCWRcepLeBZ+VA3RucRiXc6VTveyrLcWl9Jh2wKJWOBi8/SEVaaM87cjnWCSi2QuSdVFvPzdt7MFh45aeSJeSogFdavohzquM0dt4DNGG8xpNbIEL97Rp3HlclobcWUt8vfDPUit9k2xCU8NdJATQUv96JK4IRUc9QOP4jNILkHPn36y+/Q=
X-Gm-Message-State: AOJu0YwO1p23YiOTnJ2VaMSKqbUBoX9EPcJDFSMXjuKBPKjSBBH6NTlB
	0P5NV6/49NablJa03+QlTmg/uF2fBfOZdMl8QyERt962jMrk6ifj6No3AWOX
X-Google-Smtp-Source: AGHT+IFuKP3l7KTlau26G0wM3mrPudUvVpa7DYY0H6Ojuh3YVjvGMiyjNumAP1yrCQKRD2PYbzQYlw==
X-Received: by 2002:a19:ca4f:0:b0:52b:be6b:d16a with SMTP id 2adb3069b0e04-52ce183573fmr11851969e87.31.1719588253708;
        Fri, 28 Jun 2024 08:24:13 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f2e9b00e0c268ab7636554b.dip0.t-ipconnect.de. [2003:eb:5f2e:9b00:e0c2:68ab:7636:554b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72af0c9d06sm69644166b.18.2024.06.28.08.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:24:13 -0700 (PDT)
From: iansdannapel@gmail.com
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Andre Przywara <andre.przywara@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ian Dannapel <iansdannapel@gmail.com>
Subject: [PATCH v2 1/3] fpga: Add Efinix Trion & Titanium serial SPI programming driver
Date: Fri, 28 Jun 2024 17:23:46 +0200
Message-Id: <20240628152348.61133-2-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628152348.61133-1-iansdannapel@gmail.com>
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add a new driver for loading binary firmware using "SPI passive
programming" on Efinix FPGAs.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 drivers/fpga/Kconfig                    |   8 +
 drivers/fpga/Makefile                   |   1 +
 drivers/fpga/efinix-trion-spi-passive.c | 219 ++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 drivers/fpga/efinix-trion-spi-passive.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 37b35f58f0df..25579510e49e 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -83,6 +83,14 @@ config FPGA_MGR_XILINX_SPI
 	  FPGA manager driver support for Xilinx FPGA configuration
 	  over slave serial interface.
 
+config FPGA_MGR_EFINIX_SPI
+	tristate "Efinix FPGA configuration over SPI passive"
+	depends on SPI
+	help
+	  This option enables support for the FPGA manager driver to
+	  configure Efinix Trion and Titanium Series FPGAs over SPI
+	  using passive serial mode.
+
 config FPGA_MGR_ICE40_SPI
 	tristate "Lattice iCE40 SPI"
 	depends on OF && SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index aeb89bb13517..1a95124ff847 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
+obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-trion-spi-passive.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
diff --git a/drivers/fpga/efinix-trion-spi-passive.c b/drivers/fpga/efinix-trion-spi-passive.c
new file mode 100644
index 000000000000..eb2592e788b9
--- /dev/null
+++ b/drivers/fpga/efinix-trion-spi-passive.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Trion and Titanium Series FPGA SPI Passive Programming Driver
+ *
+ * Copyright (C) 2024 iris-GmbH infrared & intelligent sensors
+ *
+ * Ian Dannapel <iansdannapel@gmail.com>
+ *
+ * Manage Efinix FPGA firmware that is loaded over SPI using
+ * the serial configuration interface.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+#include <linux/sizes.h>
+
+struct efinix_spi_conf {
+	struct spi_device *spi;
+	struct gpio_desc *cdone;
+	struct gpio_desc *creset;
+	struct gpio_desc *cs;
+};
+
+static int get_cdone_gpio(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	int ret;
+
+	ret = gpiod_get_value(conf->cdone);
+	if (ret < 0)
+		dev_err(&mgr->dev, "Error reading CDONE (%d)\n", ret);
+
+	return ret;
+}
+
+static void reset(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	gpiod_set_value(conf->creset, 1);
+	/* wait tCRESET_N */
+	usleep_range(5, 15);
+	gpiod_set_value(conf->creset, 0);
+}
+
+static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	if (conf->cdone && get_cdone_gpio(mgr) == 1)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int efinix_spi_apply_clk_cycles(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	char data[13] = {0};
+
+	return spi_write(conf->spi, data, sizeof(data));
+}
+
+static int efinix_spi_write_init(struct fpga_manager *mgr,
+				 struct fpga_image_info *info,
+				 const char *buf, size_t count)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
+		return -EINVAL;
+	}
+
+	/* reset with chip select active */
+	gpiod_set_value(conf->cs, 1);
+	usleep_range(5, 15);
+	reset(mgr);
+
+	/* wait tDMIN */
+	usleep_range(100, 150);
+
+	return 0;
+}
+
+static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
+			    size_t count)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	int ret;
+
+	ret = spi_write(conf->spi, buf, count);
+	if (ret) {
+		dev_err(&mgr->dev, "SPI error in firmware write: %d\n",
+			ret);
+		return ret;
+	}
+
+	/* append at least 100 clock cycles */
+	efinix_spi_apply_clk_cycles(mgr);
+
+	/* release chip select */
+	gpiod_set_value(conf->cs, 0);
+
+	return 0;
+}
+
+static int efinix_spi_write_complete(struct fpga_manager *mgr,
+				     struct fpga_image_info *info)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	unsigned long timeout =
+		jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
+	bool expired = false;
+	int done;
+
+	if (conf->cdone) {
+		while (!expired) {
+			expired = time_after(jiffies, timeout);
+
+			done = get_cdone_gpio(mgr);
+			if (done < 0)
+				return done;
+
+			if (done)
+				break;
+		}
+	}
+
+	if (expired)
+		return -ETIMEDOUT;
+
+	/* wait tUSER */
+	usleep_range(75, 125);
+
+	return 0;
+}
+
+static const struct fpga_manager_ops efinix_spi_ops = {
+	.state = efinix_spi_state,
+	.write_init = efinix_spi_write_init,
+	.write = efinix_spi_write,
+	.write_complete = efinix_spi_write_complete,
+};
+
+static int efinix_spi_probe(struct spi_device *spi)
+{
+	struct efinix_spi_conf *conf;
+	struct fpga_manager *mgr;
+
+	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
+	if (!conf)
+		return -ENOMEM;
+
+	conf->spi = spi;
+
+	conf->creset = devm_gpiod_get(&spi->dev, "creset", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->creset))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->creset),
+				"Failed to get RESET gpio\n");
+
+	conf->cs = devm_gpiod_get(&spi->dev, "cs", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->cs))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->cs),
+				"Failed to get CHIP_SELECT gpio\n");
+
+	if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->cs),
+				"Unsupported SPI mode, set CPHA and CPOL\n");
+
+	conf->cdone = devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
+	if (IS_ERR(conf->cdone))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
+				"Failed to get CDONE gpio\n");
+
+	mgr = devm_fpga_mgr_register(&spi->dev,
+				"Efinix SPI Passive Programming FPGA Manager",
+					&efinix_spi_ops, conf);
+
+	return PTR_ERR_OR_ZERO(mgr);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id efnx_spi_of_match[] = {
+	{ .compatible = "efinix,trion-spi-passive", },
+	{ .compatible = "efinix,titanium-spi-passive", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, efnx_spi_of_match);
+#endif
+
+static const struct spi_device_id efinix_ids[] = {
+	{ "trion-spi-passive", 0 },
+	{ "titanium-spi-passive", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, efinix_ids);
+
+
+static struct spi_driver efinix_spi_passive_driver = {
+	.driver = {
+		.name = "efinix-fpga-spi-passive",
+		.of_match_table = of_match_ptr(efnx_spi_of_match),
+	},
+	.probe = efinix_spi_probe,
+	.id_table = efinix_ids,
+};
+
+module_spi_driver(efinix_spi_passive_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
+MODULE_DESCRIPTION("Load Efinix FPGA firmware over SPI passive");
-- 
2.34.1


