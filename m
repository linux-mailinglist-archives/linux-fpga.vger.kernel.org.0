Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D616E5203B3
	for <lists+linux-fpga@lfdr.de>; Mon,  9 May 2022 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiEIRmN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 May 2022 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239747AbiEIRmL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 May 2022 13:42:11 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D30218FF4;
        Mon,  9 May 2022 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=dyMkGRhEXK18co8K6ojKMRdLSlsCCUiGZiN2gvPJQFQ=;
        b=KAU9UP5Ok7w0r/jxLmL0P/b5746oBxM41MJIfVHMveebQXD7Xe3kxaNRxXpWOoDyuKVUcpeGp5BRP
         4ndjNXuX0+5Rl5ZNCNr4E0VpLBsM90O6dTGv/5HVxlbIBatYja6tDnp7ZVEma8hnmF1lms2TpqaW1n
         YSZ2z+PjJojQVzeUvJVu18d711oesJYuGQHtGgvJI2MdV6YDSqL9jaRES2G/x57FbVOIgKnmp5rlvG
         n2/r1+xKaXj75EKqmo/SuJhR/y4dGFia/E+J2f9GnMvy+1C8G2lyiNXzBKbGH2tX+Awo6NOXHOTTmF
         ep61Aw76gFOrdauKLjKBjbNZzR7L59Q==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1422, Stamp: 3], Multi: [Enabled, t: (0.000013,0.008779)], BW: [Enabled, t: (0.000014,0.000001)], RTDA: [Enabled, t: (0.105748), Hit: No, Details: v2.39.0; Id: 15.52k9mu.1g2kuc2jg.10jil; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 9 May 2022 20:37:46 +0300
Date:   Mon, 9 May 2022 20:16:21 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor.Dooley@microchip.com
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v11 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Message-ID: <20220509171621.zk4owxwlngxjodgz@x260>
References: <20220507074304.11144-1-i.bornyakov@metrotek.ru>
 <20220507074304.11144-3-i.bornyakov@metrotek.ru>
 <bd5cb37b-ee56-f6d5-2d98-c08566b60728@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5cb37b-ee56-f6d5-2d98-c08566b60728@microchip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 09, 2022 at 11:41:18AM +0000, Conor.Dooley@microchip.com wrote:
> Hey Ivan, one comment below.
> Thanks,
> Conor.
> 
> On 07/05/2022 08:43, Ivan Bornyakov wrote:
> > ... snip ...
> > +static int mpf_read_status(struct spi_device *spi)
> > +{
> > +       u8 status, status_command = MPF_SPI_READ_STATUS;
> > +       struct spi_transfer xfer = {
> > +               .tx_buf = &status_command,
> > +               .rx_buf = &status,
> > +               .len = 1,
> > +       };
> > +       int ret = spi_sync_transfer(spi, &xfer, 1);
> > +
> > +       if ((status & MPF_STATUS_SPI_VIOLATION) ||
> > +           (status & MPF_STATUS_SPI_ERROR))
> > +               ret = -EIO;
> > +
> > +       return ret ? : status;
> > +}
> > +
> > ... snip ...
> > +
> > +static int poll_status_not_busy(struct spi_device *spi, u8 mask)
> > +{
> > +       int status, timeout = MPF_STATUS_POLL_TIMEOUT;
> > +
> > +       while (timeout--) {
> > +               status = mpf_read_status(spi);
> > +               if (status < 0 ||
> > +                   (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask))))
> > +                       return status;
> > +
> > +               usleep_range(1000, 2000);
> > +       }
> > +
> > +       return -EBUSY;
> > +}
> 
> Is there a reason you changed this from the snippet you sent me
> in the responses to version 8:
> static int poll_status_not_busy(struct spi_device *spi, u8 mask)
> {
> 	u8 status, status_command = MPF_SPI_READ_STATUS;
> 	int ret, timeout = MPF_STATUS_POLL_TIMEOUT;
> 	struct spi_transfer xfer = {
> 		.tx_buf = &status_command,
> 		.rx_buf = &status,
> 		.len = 1,
> 	};
> 
> 	while (timeout--) {
> 		ret = spi_sync_transfer(spi, &xfer, 1);
> 		if (ret < 0)
> 			return ret;
> 
> 		if (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask)))
> 			return status;
> 
> 		usleep_range(1000, 2000);
> 	}
> 
> 	return -EBUSY;
> }
> 
> With the current version, I hit the "Failed to write bitstream
> frame" check in mpf_ops_write at random points in the transfer.
> Replacing poll_status_not_busy with the above allows it to run
> to completion.

In my eyes they are equivalent, aren't they?

