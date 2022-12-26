Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011386564BD
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 20:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLZTBi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 14:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiLZTBh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 14:01:37 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F52F6;
        Mon, 26 Dec 2022 11:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=/udPUY6hw47AOPn59FFJBiQT80aytM6Y0VGbFp3lP5E=;
        b=IYPBLRzSEzJ9ut3ndeK7wnx9M9hdMALfwgyou0RCqyovoQho2ttAoIl5FIPJkwZq1M/M/GmoEk0R7
         ehM1MiKL7dgC06g9LLpsikaYDX0CNB69h27JiltbzU9ExmmeXAisuF8/EROeUopg0akQhFtXPQYhkf
         zXwOJnfcE2YOqxpP0M/F/VLjY9wJXYZMlRKLd/FjfJylIlfnMFaiEK8cSE+M8KrUg5j7q69wF3FNj3
         sTl6sLvciN5QQZik9dvI3B0cyQpSccENTAspoM4j09mBr4Qnp/I9pngQVNaecQbT/kMePBWYGhcUYT
         X9bvv4T6JPEtCXlZYVsmpiojNH/4JkA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000009,0.014552)], BW: [Enabled, t: (0.000023,0.000001)], RTDA: [Enabled, t: (0.376070), Hit: No, Details: v2.42.0; Id: 15.52k9kj.1gl7sudve.646p; mclb], total: 0(700)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 26 Dec 2022 22:00:56 +0300
Date:   Mon, 26 Dec 2022 21:58:44 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        system@metrotek.ru
Subject: Re: [PATCH v2 2/3] fpga: microchip-spi: rewrite status polling in a
 time measurable way
Message-ID: <20221226185844.tvwkbzp5uz7di2gq@x260>
References: <20221226142326.8111-1-i.bornyakov@metrotek.ru>
 <20221226142326.8111-3-i.bornyakov@metrotek.ru>
 <5386279-3ce-fa0-ed5-494cb12ae6d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5386279-3ce-fa0-ed5-494cb12ae6d@linux.intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Dec 26, 2022 at 08:24:06PM +0200, Ilpo Järvinen wrote:
> On Mon, 26 Dec 2022, Ivan Bornyakov wrote:
> 
> > Original busy loop with retries count in mpf_poll_status() is not too
> > reliable, as it takes different times on different systems. Replace it
> > with read_poll_timeout() macro.
> > 
> > Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> >  drivers/fpga/microchip-spi.c | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> > index e72fedd93a27..f3ddfab87499 100644
> > --- a/drivers/fpga/microchip-spi.c
> > +++ b/drivers/fpga/microchip-spi.c
> > @@ -6,6 +6,7 @@
> >  #include <asm/unaligned.h>
> >  #include <linux/delay.h>
> >  #include <linux/fpga/fpga-mgr.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> >  #include <linux/spi/spi.h>
> > @@ -33,7 +34,7 @@
> >  
> >  #define	MPF_BITS_PER_COMPONENT_SIZE	22
> >  
> > -#define	MPF_STATUS_POLL_RETRIES		10000
> > +#define	MPF_STATUS_POLL_TIMEOUT		(2 * USEC_PER_SEC)
> >  #define	MPF_STATUS_BUSY			BIT(0)
> >  #define	MPF_STATUS_READY		BIT(1)
> >  #define	MPF_STATUS_SPI_VIOLATION	BIT(2)
> > @@ -197,21 +198,17 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
> >  /* Poll HW status until busy bit is cleared and mask bits are set. */
> >  static int mpf_poll_status(struct mpf_priv *priv, u8 mask)
> >  {
> > -	int status, retries = MPF_STATUS_POLL_RETRIES;
> > +	int ret, status;
> >  
> > -	while (retries--) {
> > -		status = mpf_read_status(priv);
> > -		if (status < 0)
> > -			return status;
> > -
> > -		if (status & MPF_STATUS_BUSY)
> > -			continue;
> > -
> > -		if (!mask || (status & mask))
> > -			return status;
> > -	}
> > +	ret = read_poll_timeout(mpf_read_status, status,
> > +				(status < 0) ||
> > +				(!(status & MPF_STATUS_BUSY) &&
> > +				 (!mask || (status & mask))),
> 
> I'm just noting that this code does not match function's comment 
> (neither pre nor post diff code). The comment claims "mask bits are set" 
> but the code tests "any mask bit set". 
> 
> However, currently it causes no issue because only MPF_STATUS_READY is 
> passed and it's BIT(1).
> 
> I think the condition matching to the comment would be this (IMHO, it is 
> also slightly simpler because !mask doesn't need to be special cased):
> 
> ((status & (MPF_STATUS_BUSY | mask)) == mask)
> 
> (But not necessarily to be changed in this patch.)
> 
> -- 
>  i.
> 

Agree. Thank you for pointing out!

> > +				0, MPF_STATUS_POLL_TIMEOUT, false, priv);
> > +	if (ret < 0)
> > +		return ret;
> >  
> > -	return -EBUSY;
> > +	return status;
> >  }
> >  
> >  static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t buf_size)
> > 
> 

