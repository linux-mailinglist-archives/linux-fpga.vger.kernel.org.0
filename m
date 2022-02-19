Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34104BC60A
	for <lists+linux-fpga@lfdr.de>; Sat, 19 Feb 2022 07:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiBSGey (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 19 Feb 2022 01:34:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiBSGey (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 19 Feb 2022 01:34:54 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F95D2245;
        Fri, 18 Feb 2022 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=GTdc3KhpH9SrVmXrydjuExxtLYQXHJtt1/afcKbRb+o=;
        b=MCpta50v+H01PD7ttCRNy8D3+IAwhyX/cwImaO9WUa0NTMP6HFDqoTOAqddKgizIkUacxIcZC6iyl
         WaCRYLO2C96JOs0Cq8WRYFCmhCrj4aRCrx0jgwl2xVnWwvSLQB6zSMMNviROiSPmf05E3jLTazWX8Z
         x1oledYm485TuB6HspCEVm0+5m+qBt64UyntFxWykJ36KLfIpAnM5bFNvkF6u136WwGmPVsIstRNW/
         +UvIR1026apQTYMvoXqFY2UxItxgbfoy1gtCGeo6XBs9lvH5qp0zD8nUxIp8HqROBWZky3yrRJE0my
         Ik07DySz1KK2UCAa3Txm5/SgDdrPpaA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1403, Stamp: 3], Multi: [Enabled, t: (0.000014,0.013593)], BW: [Enabled, t: (0.000033,0.000002)], RTDA: [Enabled, t: (0.062353), Hit: No, Details: v2.25.0; Id: 15.52kd2u.1fs8b0fb1.13cjc; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sat, 19 Feb 2022 09:34:17 +0300
Date:   Sat, 19 Feb 2022 09:16:27 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v4] fpga: microchip-spi: add Microchip FPGA manager
Message-ID: <20220219061627.3oanqx5glsyq47xk@x260>
References: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
 <20220217191851.11730-1-i.bornyakov@metrotek.ru>
 <20220218160555.GA1333893@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218160555.GA1333893@yilunxu-OptiPlex-7050>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi, Yilun.

On Sat, Feb 19, 2022 at 12:05:55AM +0800, Xu Yilun wrote:
> On Thu, Feb 17, 2022 at 10:18:51PM +0300, Ivan Bornyakov wrote:
> > +static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
> > +{
> > +	ssize_t bitstream_start = 0, bitstream_size;
> > +	struct mpf_priv *priv = mgr->priv;
> > +	struct spi_device *spi = priv->spi;
> > +	struct device *dev = &mgr->dev;
> > +	u8 tmp_buf[SPI_FRAME_SIZE + 1];
> > +	int ret, i;
> > +
> > +	if (crc_ccitt(0, buf, count)) {
> > +		dev_err(dev, "CRC error\n");
> > +
> > +		return -EINVAL;
> > +	}
> > +
> > +	bitstream_start = lookup_block_start(BITSTREAM_ID, buf, count);
> > +	if (bitstream_start < 0) {
> > +		dev_err(dev, "Failed to find bitstream start %zd\n",
> > +			bitstream_start);
> > +
> > +		return bitstream_start;
> > +	}
> > +
> > +	bitstream_size = parse_bitstream_size(buf, count);
> > +	if (bitstream_size < 0) {
> > +		dev_err(dev, "Failed to parse bitstream size %zd\n",
> > +			bitstream_size);
> > +
> > +		return bitstream_size;
> > +	}
> > +
> > +	if (bitstream_start + bitstream_size * SPI_FRAME_SIZE > count) {
> > +		dev_err(dev,
> > +			"Bitstram outruns firmware. Bitstream start %zd, bitstream size %zd, firmware size %zu\n",
> 
> 			 Bitstream
> 
> > +			bitstream_start, bitstream_size * SPI_FRAME_SIZE, count);
> > +
> > +		return -EFAULT;
> > +	}
> > +
> 
> If I understand right, this function assumes the users provide the
> entire image buffer. But it is possible the image buffer is from a
> scatter list and the callback would be called several times.
> 

That is unfortunate. I thought fpga_manager_ops->write_sg() is here for
that purpose.

>
> Maybe the bitstream info at the head of the image could be parsed in
> write_init(), and this requires the driver fill the
> fpga_manager_ops.initial_header_size
>

Header size is not known beforehand and is stored in 25th byte of the
image.

Overall, thanks for detailed review

