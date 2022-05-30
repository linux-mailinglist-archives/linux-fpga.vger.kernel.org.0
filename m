Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35740537AAB
	for <lists+linux-fpga@lfdr.de>; Mon, 30 May 2022 14:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiE3M3j (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 May 2022 08:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiE3M3i (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 May 2022 08:29:38 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974F7CB6D;
        Mon, 30 May 2022 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=JDKi/xJT1Mjieigmk3yCi+36SvkfibHsJeRVOyaZZwY=;
        b=LCXDiTp34x63byV6GKPAe4R7U39FSVzFfEQYjYcXE6X6yNJx2kydBZJJpwvyxl5WoLSd8e4M/4cHs
         xL7YAsIufpn/6wdHtK/olpvf6zxD+/CNpJ5E6v7gihDyBSZlP/GYaUvNmnUoJz4ViJvv4fKO929+vm
         lcWvrj5MF/Ah+SX4vh2fZKJ2F/GmW8CAwC5innPeLWOVp6EmfO0sl1K468JKtsgH9wQil5qD0OG3+u
         8mC/M8TZ/xQYdF/9phBK9eWM4K3oH1qdntcIT4JYZLMfyMwC+XJODu+rRXHkg+7IFp4MfBxggsKY7j
         u1/3wFztAHKRWlJc/A5dxBl3VHrfA1g==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000010,0.009374)], BW: [Enabled, t: (0.000021,0.000001)], RTDA: [Enabled, t: (0.140348), Hit: No, Details: v2.39.0; Id: 15.52k38i.1g4af248r.a270; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 30 May 2022 15:29:09 +0300
Date:   Mon, 30 May 2022 15:07:01 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor.Dooley@microchip.com
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Message-ID: <20220530120701.sedwn3qeohlnj52e@x260>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-3-i.bornyakov@metrotek.ru>
 <f655cf2f-555c-6480-a461-bcddb9e510f3@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f655cf2f-555c-6480-a461-bcddb9e510f3@microchip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 30, 2022 at 11:22:26AM +0000, Conor.Dooley@microchip.com wrote:
> On 26/05/2022 19:13, Ivan Bornyakov wrote:
> > +static int mpf_read_status(struct spi_device *spi)
> > +{
> > +       u8 status = 0, status_command = MPF_SPI_READ_STATUS;
> > +       /*
> > +        * Two identical SPI transfers are used for status reading.
> > +        * The reason is that the first one can be inadequate.
> > +        * We ignore it completely and use the second one.
> > +        */
> > +       struct spi_transfer xfers[] = {
> > +               [0 ... 1] = {
> > +                       .tx_buf = &status_command,
> > +                       .rx_buf = &status,
> > +                       .len = 1,
> > +                       .cs_change = 1,
> > +               }
> > +       };
> 
> Hmm, I don't think that this is correct, or at least it is not
> correct from the polarfire /soc/ perspective. I was told that
> there was nothing different other than the envm between the
> programming for both devices - but this is another situation
> where I start to question that.
> 
> When I run this code, ISC enable /never/ passes - failing due
> to timing out. I see something like this picture here:
> https://i.imgur.com/EKhd1S3.png
> You can see the 0x0B ISC enable coming through & then a status
> check after it.
> 
> With the current code, the value of the "status" variable will
> be 0x0, given you are overwriting the first MISO value with the
> second. According to the hw guys, the spi hw status *should*
> only be returned on MISO in the first byte after SS goes low.
> 
> If this is not the case for a non -soc part, which, as I said
> before, I don't have a board with the SPI programmer exposed
> for & I have been told is not the case then my comments can
> just be ignored entirely & I'll have some head scratching to
> do...
> 
> Thanks,
> Conor.
> 

If I understood correctly, SS doesn't alter between two status reading
transactions despite .cs_change = 1. May be adding some .cs_change_delay
to spi_transfer struct can help with that?

> > +       int ret = spi_sync_transfer(spi, xfers, 2);
> > +
> > +       if ((status & MPF_STATUS_SPI_VIOLATION) ||
> > +           (status & MPF_STATUS_SPI_ERROR))
> > +               ret = -EIO;
> > +
> > +       return ret ? : status;
> > +}

