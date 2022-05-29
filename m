Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E932D53724E
	for <lists+linux-fpga@lfdr.de>; Sun, 29 May 2022 21:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiE2TOp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 May 2022 15:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiE2TOo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 May 2022 15:14:44 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A06339D;
        Sun, 29 May 2022 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=vFlESYymQ2NwgPjDD5rnm4pnn9bLsxAU7uc0Vcg/HFQ=;
        b=hqTG3eQbjt2+IPv1cb/ST7Rmb7hNatjIXvs4fnEMZttKi1vJFf0gsqeyHq1IdcyNvG0pqxaQDEI/m
         XUoirehnVg6ck8sOagRXYlF1IUq7VEv15ah2DQpDuvzII/jfKxeX6rZMBJZ7HT5zr2tlow1ZmYJ+Ft
         Qv4B454NEQtH3y1TFMff9OpQyr25IUBI8z3YbNIKGKDqvo2hau0z7uynke2HC6PvNsy7sNSo3rUyGu
         SCcPXPNe9EqKxeylOfledOF/HOdN20Tm8bd2CSoGgNMiZ/K6224Oh7vA8XDBtLw+95tUnDgz8Lo8GY
         X6bNaDF9yH5T5beg91hxg5R9eTlaJ1Q==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000009,0.015434)], BW: [Enabled, t: (0.000014,0.000001)], RTDA: [Enabled, t: (0.073164), Hit: No, Details: v2.39.0; Id: 15.52k1mk.1g48jr39u.jv95; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sun, 29 May 2022 22:14:13 +0300
Date:   Sun, 29 May 2022 21:51:58 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor.Dooley@microchip.com
Cc:     yilun.xu@intel.com, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Message-ID: <20220529185158.gjoxrb65gpnh4g3k@x260>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-3-i.bornyakov@metrotek.ru>
 <20220529123954.GB185904@yilunxu-OptiPlex-7050>
 <3d44115c-08c8-07ee-e707-617cfbe0352f@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d44115c-08c8-07ee-e707-617cfbe0352f@microchip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, May 29, 2022 at 01:03:10PM +0000, Conor.Dooley@microchip.com wrote:
> On 29/05/2022 13:39, Xu Yilun wrote:
> > On Thu, May 26, 2022 at 09:13:43PM +0300, Ivan Bornyakov wrote:
> >> Add support to the FPGA manager for programming Microchip Polarfire
> >> FPGAs over slave SPI interface with .dat formatted bitsream image.
> > 
> > From previous mail thread, there are still some hardware operations yet
> > to be clarified, so I may need a Reviewed-by from Conor.Dooley@microchip.com.
> 
> Yeah, was really busy last week. Planning on giving this version a go
> tomorrow. I *think* I explained the reason the status check needed to be a
> sync_transfer() but it hasn't been reflected in a comment yet.
> 
> I didn't know the answers to the two other questions & passed them on to the
> designers of the hardware blocks - but both are traveling so not got a
> response yet. There's one bit of clarification I'd like from your:
> 
> >>> +static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
> >>> +{
> >>> +	u8 tmp_buf[MPF_SPI_FRAME_SIZE + 1] = { MPF_SPI_FRAME, };
> >>> +	struct mpf_priv *priv = mgr->priv;
> >>> +	struct device *dev = &mgr->dev;
> >>> +	struct spi_device *spi;
> >>> +	int ret, i;
> >>> +
> >>> +	if (count % MPF_SPI_FRAME_SIZE) {
> >>> +		dev_err(dev, "Bitstream size is not a multiple of %d\n",
> >>> +			MPF_SPI_FRAME_SIZE);
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	spi = priv->spi;
> >>> +
> >>> +	for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
> >>> +		memcpy(tmp_buf + 1, buf + i * MPF_SPI_FRAME_SIZE,
> >>> +		       MPF_SPI_FRAME_SIZE);
> >>> +
> >>> +		ret = mpf_spi_write(spi, tmp_buf, sizeof(tmp_buf));
> >>
> >> As I mentioned before, is it possible we use spi_sync_transfer to avoid
> >> memcpy the whole bitstream?
> >
> > Unfortunately, I didn't succeed with spi_sunc_transfer here. May be
> > Conor or other folks with more insight on Microchip's HW would be able
> > to eliminate this memcpy...
> 
> I understood this as being a question about why it was required to check
> the status of the hardware between frames of the bitstream rather than
> using spi_sync_transfer() to copy each frame back to back.
> 
> Is that correct?

No.
The issue here is memcpy() a bitstream data frame to temporary buffer
before sending it to the device.
The reason for memcpy() is that we need to send to the device 17 bytes:
1st byte 0xEE and next 16 bytes - bitstream data.
Possible solution to eliminate memcpy() is to use spi_sync_transfer()
instead of spi_write() for sending bitstream frames, like so:

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 7579b0de119f..bf62ee7fd630 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -270,7 +270,8 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,

 static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
 {
-       u8 tmp_buf[MPF_SPI_FRAME_SIZE + 1] = { MPF_SPI_FRAME, };
+       u8 spi_frame_command = MPF_SPI_FRAME;
+       struct spi_transfer xfers[2] = { 0 };
        struct mpf_priv *priv = mgr->priv;
        struct device *dev = &mgr->dev;
        struct spi_device *spi;
@@ -285,10 +286,15 @@ static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count
        spi = priv->spi;

        for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
-               memcpy(tmp_buf + 1, buf + i * MPF_SPI_FRAME_SIZE,
-                      MPF_SPI_FRAME_SIZE);
+               xfers[0].tx_buf = &spi_frame_command;
+               xfers[0].len = 1;
+               xfers[1].tx_buf = buf + i * MPF_SPI_FRAME_SIZE;
+               xfers[1].len = MPF_SPI_FRAME_SIZE;
+
+               ret = mpf_poll_status(spi, 0);
+               if (ret >= 0)
+                       ret = spi_sync_transfer(spi, xfers, 2);

-               ret = mpf_spi_write(spi, tmp_buf, sizeof(tmp_buf));
                if (ret) {
                        dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
                                i, count / MPF_SPI_FRAME_SIZE);

Note that this is not a working solution.

