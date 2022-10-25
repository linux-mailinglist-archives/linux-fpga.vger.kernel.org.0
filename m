Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C860CAAE
	for <lists+linux-fpga@lfdr.de>; Tue, 25 Oct 2022 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiJYLNf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 25 Oct 2022 07:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJYLNf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 25 Oct 2022 07:13:35 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C5318194C;
        Tue, 25 Oct 2022 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=BfioPz7Gh4xtsZmNJPRfyWcmTTsR07b3GsCjLfhkMoQ=;
        b=ZLY9HSgJHv9Kqiwtu85TZyRYCzqmHRnvLXmBIxfq9VS3sEgn/SyN3yPxIlaDtgYrLVn2LBHpW7wmt
         kRzhHo3q8LFMzm5DzETDq0HtCZ9ZgdfNBEbtHFiB7XCzTjniCc1NsYDWzY4ugKdFD9PCumBmgwvlXw
         CItlHShz/8EVdWAH74A7OWNriYxrJLSOZIgty4fS8SlWs/7JlfJbNx7qx1PSy4CvcQabiMe9rxPfwf
         XHUikNCgrj1k9UO6WNVH3V5LXNrZDRHSez+gx/9EdC2ZLMEkUoilrfV5EDsRPgHBaAil8Dy5BQv01H
         hWGPHfcs/bCo2Zh8ga9E0dBlzsmKcow==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000009,0.006414)], BW: [Enabled, t: (0.000018,0.000001)], RTDA: [Enabled, t: (0.071619), Hit: No, Details: v2.42.0; Id: 15.52k1ot.1gg7dhp45.buia; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 25 Oct 2022 14:13:24 +0300
Date:   Tue, 25 Oct 2022 14:11:54 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v20 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20221025111154.d4o6hvya2fb6hmev@h-e2.ddg>
References: <20221025053947.2737-1-i.bornyakov@metrotek.ru>
 <20221025053947.2737-2-i.bornyakov@metrotek.ru>
 <Y1eILk6ArO5OVzwW@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1eILk6ArO5OVzwW@yilunxu-OptiPlex-7050>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 25, 2022 at 02:54:38PM +0800, Xu Yilun wrote:
> On 2022-10-25 at 08:39:46 +0300, Ivan Bornyakov wrote:
> > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > slave SPI sysCONFIG interface.
> > 
> > sysCONFIG interface core functionality is separate from both ECP5 and
> > SPI specifics, so support for other FPGAs with different port types can
> > be added in the future.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> 
> [...]
> 
> > +static int sysconfig_spi_bitstream_burst_init(struct sysconfig_priv *priv)
> > +{
> > +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> > +	struct spi_device *spi = to_spi_device(priv->dev);
> > +	struct spi_transfer xfer = {};
> > +	struct spi_message msg;
> > +	size_t buf_len;
> > +	void *buf;
> > +	int ret;
> > +
> > +	buf_len = sizeof(lsc_bitstream_burst);
> > +
> > +	buf = kmemdup(lsc_bitstream_burst, buf_len, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +
> 
> I removed the second blank line and applied this series to for-next.
> 

Sorry for this negligence. Thanks.

