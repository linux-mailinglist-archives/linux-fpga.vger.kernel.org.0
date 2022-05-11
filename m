Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7154522E0F
	for <lists+linux-fpga@lfdr.de>; Wed, 11 May 2022 10:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbiEKIQM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 May 2022 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbiEKIQK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 11 May 2022 04:16:10 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD73FBCB;
        Wed, 11 May 2022 01:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=hTDd4TSeU1fwQ6OaAmsGqmYgAJLDuU+/nhoN5LyCky4=;
        b=ldKQ+oOIE/MncLwS3922wAbJevpexSt+HIQxIYg1unHt/01VteHHELxNQxNb+R1+KiqjTOsQgy2ne
         DuHGgS1XmmAtT6yr9aGsyRSS9V2SMw2SyECTM6pZ+CuRcoc9YLffWIuV977YTHC0JpthZYFqsaXMhy
         0waSNrTrfjWwpheLYEOJ96j+mhDCFYmC8kqIds/088PSv/oRnZ1jyugaljHdWYmeEr8yB1Bc7XOVHU
         ktKpu8wb7hf8KGl7eKPSX4V3LTEG1XBZCVRQhGQkD6lpTsEGuyLTNeadAGsU/Kg2U4GZWYDRNimAOY
         betkaC2da3ivsJSOYDg+T51TMwygUiQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1422, Stamp: 3], Multi: [Enabled, t: (0.000010,0.016053)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.071124), Hit: No, Details: v2.39.0; Id: 15.52k1cv.1g2p30lbn.venk; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 11 May 2022 11:15:51 +0300
Date:   Wed, 11 May 2022 11:15:32 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Conor.Dooley@microchip.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v11 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Message-ID: <20220511081532.7gkmz3uumzxgwfaf@h-e2.ddg>
References: <20220507074304.11144-1-i.bornyakov@metrotek.ru>
 <20220507074304.11144-3-i.bornyakov@metrotek.ru>
 <bd5cb37b-ee56-f6d5-2d98-c08566b60728@microchip.com>
 <20220509171621.zk4owxwlngxjodgz@x260>
 <da1e5125-de6b-11a8-a52d-7e6e5f45ab70@conchuod.ie>
 <4b752147-1a09-a4af-bc5d-3b132b84ef49@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b752147-1a09-a4af-bc5d-3b132b84ef49@conchuod.ie>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 10, 2022 at 12:29:54PM +0100, Conor Dooley wrote:
> On 09/05/2022 19:56, Conor Dooley wrote:
> > On 09/05/2022 18:16, Ivan Bornyakov wrote:
> > > On Mon, May 09, 2022 at 11:41:18AM +0000, Conor.Dooley@microchip.com wrote:
> > > > Hey Ivan, one comment below.
> > > > Thanks,
> > > > Conor.
> > > > 
> > > > On 07/05/2022 08:43, Ivan Bornyakov wrote:
> > > > > ... snip ...
> > > > > +static int mpf_read_status(struct spi_device *spi)
> > > > > +{
> > > > > +       u8 status, status_command = MPF_SPI_READ_STATUS;
> > > > > +       struct spi_transfer xfer = {
> > > > > +               .tx_buf = &status_command,
> > > > > +               .rx_buf = &status,
> > > > > +               .len = 1,
> > > > > +       };
> > > > > +       int ret = spi_sync_transfer(spi, &xfer, 1);
> > > > > +
> > > > > +       if ((status & MPF_STATUS_SPI_VIOLATION) ||
> > > > > +           (status & MPF_STATUS_SPI_ERROR))
> > > > > +               ret = -EIO;
> > > > > +
> > > > > +       return ret ? : status;
> > > > > +}
> > > > > +
> > > > > ... snip ...
> > > > > +
> > > > > +static int poll_status_not_busy(struct spi_device *spi, u8 mask)
> > > > > +{
> > > > > +       int status, timeout = MPF_STATUS_POLL_TIMEOUT;
> > > > > +
> > > > > +       while (timeout--) {
> > > > > +               status = mpf_read_status(spi);
> > > > > +               if (status < 0 ||
> > > > > +                   (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask))))
> > > > > +                       return status;
> > > > > +
> > > > > +               usleep_range(1000, 2000);
> > > > > +       }
> > > > > +
> > > > > +       return -EBUSY;
> > > > > +}
> > > > 
> > > > Is there a reason you changed this from the snippet you sent me
> > > > in the responses to version 8:
> > > > static int poll_status_not_busy(struct spi_device *spi, u8 mask)
> > > > {
> > > > 	u8 status, status_command = MPF_SPI_READ_STATUS;
> > > > 	int ret, timeout = MPF_STATUS_POLL_TIMEOUT;
> > > > 	struct spi_transfer xfer = {
> > > > 		.tx_buf = &status_command,
> > > > 		.rx_buf = &status,
> > > > 		.len = 1,
> > > > 	};
> > > > 
> > > > 	while (timeout--) {
> > > > 		ret = spi_sync_transfer(spi, &xfer, 1);
> > > > 		if (ret < 0)
> > > > 			return ret;
> > > > 
> > > > 		if (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask)))
> > > > 			return status;
> > > > 
> > > > 		usleep_range(1000, 2000);
> > > > 	}
> > > > 
> > > > 	return -EBUSY;
> > > > }
> > > > 
> > > > With the current version, I hit the "Failed to write bitstream
> > > > frame" check in mpf_ops_write at random points in the transfer.
> > > > Replacing poll_status_not_busy with the above allows it to run
> > > > to completion.
> > > 
> > > In my eyes they are equivalent, aren't they?
> > > 
> > 
> > I was in a bit of a rush today & didn't have time to do proper
> > debugging, I'll put some debug code in tomorrow and try to find
> > exactly what is different between the two.
> > 
> > Off the top of my head, since I don't have a board on me to test,
> > the only difference I can see is that with the snippet you only
> > checked if spi_sync_transfer was negative whereas now you check
> > if it has a value at all w/ that ternary operator.
> > 
> > But even that seems like it *shouldn't* be the problem, since ret
> > should contain -errno or zero, right?
> > Either way, I will do some digging tomorrow.
> 
> I put a printk("status %x, ret %d", status, ret); into the failure
> path of mpf_read_status() & it looks like a status 0xA is being
> returned - error & ready? That seems like a very odd combo to be
> getting back out of it. It shouldn't be dodgy driver/connection
> either, b/c that's what I see if I connect my protocol analyser:
> https://i.imgur.com/VbjgfCk.png
> 
> That's mosi (hex), ss, sclk, mosi, miso (hex), miso in descending
> order.
> 
> I think what was happening was with the snippet you returned one
> of the following: -EBUSY, ret (aka -errno) or status. Since status
> is positive, the checks in mpf_spi_write.*() saw nothing wrong at
> all and programming continued despite there being a problem.
> 
> The new version fixes this by returning -EIO rather than status from
> poll_status_not_busy().
> 
> I wish I had a socketable PolarFire so I could investigate further,
> but this looks like it might a be hardware issue somewhere on my
> end?
> 
> So ye, sorry for the noise and carry on! I'll try tofind what is to
> blame for it.
> 
> Thanks,
> Conor.
> 

Hi, Conor.

I've just noticed in SPI-DirectC User Guide [1] ch. 9 SmartFusion2 and
IGLOO2 SPI-Slave Programming Waveform Analysis, that hw status checked
two times every time. Does MPF family also need double check hw status?
Does adding second mpf_read_status() to poll_status_not_busy() routine
help with your issue?

