Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2D73257
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbfGXO5I (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 10:57:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39358 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387448AbfGXO5H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 24 Jul 2019 10:57:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so21363916pgi.6
        for <linux-fpga@vger.kernel.org>; Wed, 24 Jul 2019 07:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AST/4O/eq2Sza1xEm2Wbk0z0iSYP50Qycw9UOOMM4qo=;
        b=LJ/vAklx3u+mOBORFsX9xL2oQEVmjlEpFIcIp8eTqXiIjS2R3dOcGljtbVnDiojODQ
         w2LtOeP6Mvw1aFAPqpYYv93Wft6S65Ii5zzSN4I4rvvbLlBJcTpAe9OmL6mjwV4q01ht
         jjDg2X6vipzjSRjJwYJi4NWiQu2bhDNpFxBlwDjl/LcFrftzJPZn6JgHAUgn2qexgOrz
         lmS6XdmpRFAuRfK4txcEmzK9wqjVG+Dd4BuFMyKAUNVsAKbzclQcL1DMuG+4Qk1G9b41
         9+9DiR8uLFodWzldn0rwN7F2OCKvk8ewG4nhX8BHUBekIuitHa5o8EciIGjJumTs5f17
         x6/w==
X-Gm-Message-State: APjAAAW0lrCxp0beBmEkxkrz4DX5CQ1Qv1rVkMnc+vbEbTJc3xs2IDQp
        ex6xAbP4XPWl0fgcJLg6XsX9MAxNl0E=
X-Google-Smtp-Source: APXvYqy63MsFnB5IBu6jUh65OwJobUp6vYiO+zGqqecumVlRqQ8FJ9r/47ZzsvXz4zMNQmoNdUPc7Q==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr88467368pjb.19.1563980226593;
        Wed, 24 Jul 2019 07:57:06 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id t8sm51985102pfq.31.2019.07.24.07.57.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 07:57:05 -0700 (PDT)
Date:   Wed, 24 Jul 2019 07:57:04 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, richard.gong@linux.intel.com,
        agust@denx.de, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] fpga: altera-cvp: Preparation for V2 parts.
Message-ID: <20190724145704.GB24455@archbox>
References: <1563317287-18834-1-git-send-email-thor.thayer@linux.intel.com>
 <1563317287-18834-3-git-send-email-thor.thayer@linux.intel.com>
 <20190722005938.GB2583@archbook>
 <6e54c0ee-b8ec-4f95-cf81-70aacc82c72e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e54c0ee-b8ec-4f95-cf81-70aacc82c72e@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 23, 2019 at 09:40:51AM -0500, Thor Thayer wrote:
> Hi Moritz,
> 
> On 7/21/19 7:59 PM, Moritz Fischer wrote:
> > Thor,
> > 
> > On Tue, Jul 16, 2019 at 05:48:06PM -0500, thor.thayer@linux.intel.com wrote:
> > > From: Thor Thayer <thor.thayer@linux.intel.com>
> > > 
> > > In preparation for adding newer V2 parts that use a FIFO,
> > > reorganize altera_cvp_chk_error() and change the write
> > > function to block based.
> > > V2 parts have a block size matching the FIFO while older
> > > V1 parts write a 32 bit word at a time.
> > > 
> > > Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> > > ---
> > > v2 Remove inline function declaration
> > >     Reverse Christmas Tree format for local variables
> > > ---
> > >   drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++-----------------
> > >   1 file changed, 46 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > > index b78c90580071..37419d6b9915 100644
> > > --- a/drivers/fpga/altera-cvp.c
> > > +++ b/drivers/fpga/altera-cvp.c
> > > @@ -140,6 +140,41 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
> > >   	return -ETIMEDOUT;
> > >   }
> > > +static int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
> > > +{
> > > +	struct altera_cvp_conf *conf = mgr->priv;
> > > +	u32 val;
> > > +
> > > +	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
> > > +	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> > Same as in the other email, why can we ignore return values here. I
> > think the original code probably did that already.
> 
> Yes, I actually didn't make any changes to this function. You can see I
> moved it from below since it is used in the following function.
> 
> I'm not checking the return code from any of the read/write functions since
> the original driver didn't. Would you prefer I check and issue a warning?

Not sure a warning would change much here. We should probably look at
why it was ok in the first place.
> 
> Thanks for reviewing!
> 
> > > +	if (val & VSE_CVP_STATUS_CFG_ERR) {
> > > +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
> > > +			bytes);
> > > +		return -EPROTO;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static int altera_cvp_send_block(struct altera_cvp_conf *conf,
> > > +				 const u32 *data, size_t len)
> > > +{
> > > +	u32 mask, words = len / sizeof(u32);
> > > +	int i, remainder;
> > > +
> > > +	for (i = 0; i < words; i++)
> > > +		conf->write_data(conf, *data++);
> > > +
> > > +	/* write up to 3 trailing bytes, if any */
> > > +	remainder = len % sizeof(u32);
> > > +	if (remainder) {
> > > +		mask = BIT(remainder * 8) - 1;
> > > +		if (mask)
> > > +			conf->write_data(conf, *data & mask);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static int altera_cvp_teardown(struct fpga_manager *mgr,
> > >   			       struct fpga_image_info *info)
> > >   {
> > > @@ -262,39 +297,29 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
> > >   	return 0;
> > >   }
> > > -static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
> > > -{
> > > -	struct altera_cvp_conf *conf = mgr->priv;
> > > -	u32 val;
> > > -
> > > -	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
> > > -	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> > > -	if (val & VSE_CVP_STATUS_CFG_ERR) {
> > > -		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
> > > -			bytes);
> > > -		return -EPROTO;
> > > -	}
> > > -	return 0;
> > > -}
> > > -
> > >   static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
> > >   			    size_t count)
> > >   {
> > >   	struct altera_cvp_conf *conf = mgr->priv;
> > > +	size_t done, remaining, len;
> > >   	const u32 *data;
> > > -	size_t done, remaining;
> > >   	int status = 0;
> > > -	u32 mask;
> > >   	/* STEP 9 - write 32-bit data from RBF file to CVP data register */
> > >   	data = (u32 *)buf;
> > >   	remaining = count;
> > >   	done = 0;
> > > -	while (remaining >= 4) {
> > > -		conf->write_data(conf, *data++);
> > > -		done += 4;
> > > -		remaining -= 4;
> > > +	while (remaining) {
> > > +		if (remaining >= sizeof(u32))
> > > +			len = sizeof(u32);
> > > +		else
> > > +			len = remaining;
> > > +
> > > +		altera_cvp_send_block(conf, data, len);
> > > +		data++;
> > > +		done += len;
> > > +		remaining -= len;
> > >   		/*
> > >   		 * STEP 10 (optional) and STEP 11
> > > @@ -312,11 +337,6 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
> > >   		}
> > >   	}
> > > -	/* write up to 3 trailing bytes, if any */
> > > -	mask = BIT(remaining * 8) - 1;
> > > -	if (mask)
> > > -		conf->write_data(conf, *data & mask);
> > > -
> > >   	if (altera_cvp_chkcfg)
> > >   		status = altera_cvp_chk_error(mgr, count);
> > > -- 
> > > 2.7.4
> > > 
> > Cheers,
> > Moritz
> > 
> 

Moritz
