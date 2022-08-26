Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94FD5A286C
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Aug 2022 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbiHZNTi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Aug 2022 09:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbiHZNTh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Aug 2022 09:19:37 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686C1D290E;
        Fri, 26 Aug 2022 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=vTdTu4eptCXWJt5HBZjzWU0GSuFw4J4qaUPkVx7bNfc=;
        b=PqTC+ebwk9QLUsxstG1CnAWhnYwXtKnaBudQeU3lrHlEJSzlpNA8Ew0X7FokpFwqL5CyJNYd6Kc13
         Ayyaqp+pCQ3+EyOQ7TV+zvXJeOXxBozXy1EN/RLvNd9WthnajS1Lxi1ALozqOSe9wqY/Tm/FMGte0L
         2vqaMvu0DPh1fKt4YXCmvfomB7D9VR3Q2g/bCvw1hXK6HKx1LzYFv8WYvEwF9Ww/WKcsQPHZiVdAjg
         WyYInvC/K8jbQaVltQM8Uz1/5JS0V/YhBfytUG5SQhP1C70mZGTK2vLZ4+Auun4qbjyzsHbd737B2B
         vcLRTwnImbtKC6cOFHTDHJcAObFDvJA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000011,0.028306)], BW: [Enabled, t: (0.000019,0.000001)], RTDA: [Enabled, t: (0.079738), Hit: No, Details: v2.41.0; Id: 15.52k7h3.1gbd4tcjl.mf; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 26 Aug 2022 16:19:25 +0300
Date:   Fri, 26 Aug 2022 16:18:27 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, j.zink@pengutronix.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru,
        kernel@pengutronix.de
Subject: Re: [PATCH v8 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20220826131827.qngjd6c66q6gzzs7@h-e2.ddg>
References: <20220825112433.14583-1-i.bornyakov@metrotek.ru>
 <20220825112433.14583-2-i.bornyakov@metrotek.ru>
 <20220826105721.f3ogdleetqbfatwx@h-e2.ddg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826105721.f3ogdleetqbfatwx@h-e2.ddg>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Aug 26, 2022 at 01:57:21PM +0300, Ivan Bornyakov wrote:
> On Thu, Aug 25, 2022 at 02:24:32PM +0300, Ivan Bornyakov wrote:
> > Add support to the FPGA manager for programming Lattice ECP5 and MachXO2
> > FPGAs over slave SPI sysCONFIG interface.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> >
> > ... snip ...
> >
> > +
> > +struct sysconfig_priv {
> > +	struct gpio_desc *program;
> > +	struct gpio_desc *init;
> > +	struct gpio_desc *done;
> > +	struct spi_device *spi;
> > +	u8 isc_enable_operand;
> > +	u8 isc_erase_operand;
> > +};
> 
> As Johannes Zink working on adding I2C to MachXO2, I am thinking how
> about we add to struct sysconfig_priv a callback
> 
> int (*sysconfig_transfer)(struct sysconfig_priv,
> 			  const void *tx_buf, size_t tx_len,
> 			  void *rx_buf, size_t rx_len)
> 
> For SPI it would be defined like this:
> 
> static int sysconfig_spi_transfer(struct sysconfig_priv *data,
> 				  const void *tx_buf, size_t tx_len,
> 				  void *rx_buf, size_t rx_len)
> {
> 	if (!rx_buf)
> 		return spi_write(data->spi, tx_buf, tx_size);
> 	
> 	return spi_write_then_read(data->spi, tx_buf, tx_size, rx_buf, rx_size);
> }
> 
> And later in sysconfig_ commands we would call this callback.
> 
> Would it be a good enough starting base for Johannes to add I2C interface
> for MachXO2?
> 
> >
> > ... snip ...
> >
> > +static int sysconfig_isc_enable(struct sysconfig_priv *data)
> > +{
> > +	u8 isc_enable[] = SYSCONFIG_ISC_ENABLE;
> > +	u32 status;
> > +	int ret;
> > +
> > +	isc_enable[1] = data->isc_enable_operand;
> > +
> > +	ret = spi_write(data->spi, isc_enable, sizeof(isc_enable));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = sysconfig_poll_status(data, &status);
> > +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> > +		return ret ? : -EFAULT;
> > +
> > +	return 0;
> > +}
> 
> Quirks for I2C enable and refresh commands are 3-bytes instead of
> 4-bytes for SPI can be added here. Just check which of data->spi or
> data->i2c is not NULL.
> 

Actually, here is a patch for your tinkering.

I guess, what you need to do for MachXO2 I2C support is:
1) implement sysconfig_transfer callback for I2C. Something like this:

static int sysconfig_i2c_transfer(struct sysconfig_priv *data,
				  const void *tx_buf, size_t tx_len,
				  void *rx_buf, size_t rx_len)
{
	struct i2c_client *i2c = data->i2c;
	struct i2c_msg msg[] = {
		{
			.addr = i2c->addr,
			.flags = 0,
			.buf = tx_buf,
			.len = tx_len,
		}, {
			.addr = i2c->addr,
			.flags = I2C_M_RD,
			.buf = rx_buf,
			.len = rx_len,
		}
	};

	if (!rx_buf)
		return i2c_master_send(i2c, tx_buf, tx_len);

	return i2c_transfer(i2c->adapter, msg, ARRAY_SIZE(msg));
}

2) add quirks for 3-byte transfer to sysconfig_refresh() and
   sysconfig_isc_enable()
3) add probe routine
4) add separate fpga_manager_ops->write() for I2C
   state(), write_init() and write_complete() can be reused



---
 drivers/fpga/lattice-sysconfig-spi.c | 46 ++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
index 145b5b27b88d..c2caf613d2f0 100644
--- a/drivers/fpga/lattice-sysconfig-spi.c
+++ b/drivers/fpga/lattice-sysconfig-spi.c
@@ -41,8 +41,21 @@ struct sysconfig_priv {
 	struct spi_device *spi;
 	u8 isc_enable_operand;
 	u8 isc_erase_operand;
+	int (*sysconfig_transfer)(struct sysconfig_priv *data,
+				  const void *tx_buf, size_t tx_len,
+				  void *rx_buf, size_t rx_len);
 };
 
+static int sysconfig_spi_transfer(struct sysconfig_priv *data,
+				  const void *tx_buf, size_t tx_len,
+				  void *rx_buf, size_t rx_len)
+{
+	if (!rx_buf)
+		return spi_write(data->spi, tx_buf, tx_len);
+
+	return spi_write_then_read(data->spi, tx_buf, tx_len, rx_buf, rx_len);
+}
+
 static int sysconfig_poll_busy(struct sysconfig_priv *data)
 {
 	const u8 lsc_check_busy[] = SYSCONFIG_LSC_CHECK_BUSY;
@@ -50,9 +63,9 @@ static int sysconfig_poll_busy(struct sysconfig_priv *data)
 	u8 busy;
 
 	while (retries--) {
-		ret = spi_write_then_read(data->spi,
-					  lsc_check_busy, sizeof(lsc_check_busy),
-					  &busy, sizeof(busy));
+		ret = data->sysconfig_transfer(data, lsc_check_busy,
+					       sizeof(lsc_check_busy),
+					       &busy, sizeof(busy));
 		if (ret)
 			return ret;
 
@@ -71,9 +84,9 @@ static int sysconfig_read_status(struct sysconfig_priv *data, u32 *status)
 	__be32 device_status;
 	int ret;
 
-	ret = spi_write_then_read(data->spi,
-				  lsc_read_status, sizeof(lsc_read_status),
-				  &device_status, sizeof(device_status));
+	ret = data->sysconfig_transfer(data, lsc_read_status,
+				       sizeof(lsc_read_status),
+				       &device_status, sizeof(device_status));
 	if (ret)
 		return ret;
 
@@ -116,7 +129,8 @@ static int sysconfig_refresh(struct sysconfig_priv *data)
 	static const u8 lsc_refresh[] = SYSCONFIG_LSC_REFRESH;
 	int ret;
 
-	ret = spi_write(data->spi, lsc_refresh, sizeof(lsc_refresh));
+	ret = data->sysconfig_transfer(data, lsc_refresh, sizeof(lsc_refresh),
+				       NULL, 0);
 	if (ret)
 		return ret;
 
@@ -133,7 +147,8 @@ static int sysconfig_isc_enable(struct sysconfig_priv *data)
 
 	isc_enable[1] = data->isc_enable_operand;
 
-	ret = spi_write(data->spi, isc_enable, sizeof(isc_enable));
+	ret = data->sysconfig_transfer(data, isc_enable, sizeof(isc_enable),
+				       NULL, 0);
 	if (ret)
 		return ret;
 
@@ -152,7 +167,8 @@ static int sysconfig_isc_erase(struct sysconfig_priv *data)
 
 	isc_erase[1] = data->isc_erase_operand;
 
-	ret = spi_write(data->spi, isc_erase, sizeof(isc_erase));
+	ret = data->sysconfig_transfer(data, isc_erase, sizeof(isc_erase),
+				       NULL, 0);
 	if (ret)
 		return ret;
 
@@ -178,7 +194,8 @@ static int sysconfig_lsc_init_addr(struct sysconfig_priv *data)
 {
 	const u8 lsc_init_addr[] = SYSCONFIG_LSC_INIT_ADDR;
 
-	return spi_write(data->spi, lsc_init_addr, sizeof(lsc_init_addr));
+	return data->sysconfig_transfer(data, lsc_init_addr,
+					sizeof(lsc_init_addr), NULL, 0);
 }
 
 static int sysconfig_lsc_bitstream_burst(struct sysconfig_priv *data)
@@ -202,7 +219,8 @@ static int sysconfig_isc_prog_done(struct sysconfig_priv *data)
 	u32 status;
 	int ret;
 
-	ret = spi_write(data->spi, isc_prog_done, sizeof(isc_prog_done));
+	ret = data->sysconfig_transfer(data, isc_prog_done,
+				       sizeof(isc_prog_done), NULL, 0);
 	if (ret)
 		return ret;
 
@@ -220,7 +238,8 @@ static int sysconfig_isc_disable(struct sysconfig_priv *data)
 {
 	const u8 isc_disable[] = SYSCONFIG_ISC_DISABLE;
 
-	return spi_write(data->spi, isc_disable, sizeof(isc_disable));
+	return data->sysconfig_transfer(data, isc_disable, sizeof(isc_disable),
+					NULL, 0);
 }
 
 static enum fpga_mgr_states ecp5_ops_state(struct fpga_manager *mgr)
@@ -336,7 +355,7 @@ static int ecp5_ops_write_complete(struct fpga_manager *mgr,
 	spi_bus_unlock(spi->controller);
 
 	/* Toggle CS and wait for bitstream write to finish */
-	ret = spi_write(spi, NULL, 0);
+	ret = priv->sysconfig_transfer(priv, NULL, 0, NULL, 0);
 	if (!ret)
 		ret = sysconfig_poll_busy(priv);
 
@@ -575,6 +594,7 @@ static int sysconfig_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	priv->spi = spi;
+	priv->sysconfig_transfer = sysconfig_spi_transfer;
 
 	probe_func = of_device_get_match_data(&spi->dev);
 	if (!probe_func) {
-- 
2.37.2


