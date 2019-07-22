Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7186F6D9
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Jul 2019 02:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfGVA7k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 Jul 2019 20:59:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34371 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbfGVA7k (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 21 Jul 2019 20:59:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so10598000pgc.1;
        Sun, 21 Jul 2019 17:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pUVIHMC+qU6cGfGTmxWkAdd322WxxOroxdblKZHZ2h4=;
        b=qDbIHinQcCGUB1mEms/T1lrtvY5SAAXiqQBTW2liDMt5RylF+yMJpxKksHX65AxHIS
         ZpjzqKIfVxpD3evv5T28XpCwQLDcyQ+CeysY7iNnKgyILPPHd+4Vw//b9pacyROMOkkV
         D2wuVeYoowZnC9zpp97SAESitxVBYKXPfdKYTMWntcUM9Uadu5R1iyXr5E1aBhV2LMpE
         lbK/TAGhRvAXB83USK4evRhi67SvAxIJ6jMnTt8DDVW4zxaNhgX0C2pA+wsGc2mVuUBt
         IuGnSBwMv4dXX1FBXlfJm05FHmzHoFd7BPrah/s554g/9S8Rim4G2btxLUze18yzIcZK
         ir8g==
X-Gm-Message-State: APjAAAXhjv3CNljrQA00+WTWNJTcOHPf/An4Webr1l8ff3ppgVTqyCEv
        teiwr872158U+Z7ozmJaG6o=
X-Google-Smtp-Source: APXvYqzkYPIOfim9Sgsf8uoSSlevl6wj/Gav4RnLWZBllAVWYqwWyMNOHhMI4wfYeyEYKyk6gxktiQ==
X-Received: by 2002:a63:d301:: with SMTP id b1mr61366797pgg.379.1563757179509;
        Sun, 21 Jul 2019 17:59:39 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:aba9:7dd5:dfa6:e012])
        by smtp.gmail.com with ESMTPSA id b29sm63225519pfr.159.2019.07.21.17.59.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 17:59:38 -0700 (PDT)
Date:   Sun, 21 Jul 2019 17:59:38 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     mdf@kernel.org, richard.gong@linux.intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] fpga: altera-cvp: Preparation for V2 parts.
Message-ID: <20190722005938.GB2583@archbook>
References: <1563317287-18834-1-git-send-email-thor.thayer@linux.intel.com>
 <1563317287-18834-3-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563317287-18834-3-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Thor,

On Tue, Jul 16, 2019 at 05:48:06PM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> In preparation for adding newer V2 parts that use a FIFO,
> reorganize altera_cvp_chk_error() and change the write
> function to block based.
> V2 parts have a block size matching the FIFO while older
> V1 parts write a 32 bit word at a time.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2 Remove inline function declaration
>    Reverse Christmas Tree format for local variables
> ---
>  drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index b78c90580071..37419d6b9915 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -140,6 +140,41 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
>  	return -ETIMEDOUT;
>  }
>  
> +static int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
> +{
> +	struct altera_cvp_conf *conf = mgr->priv;
> +	u32 val;
> +
> +	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
> +	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
Same as in the other email, why can we ignore return values here. I
think the original code probably did that already.
> +	if (val & VSE_CVP_STATUS_CFG_ERR) {
> +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
> +			bytes);
> +		return -EPROTO;
> +	}
> +	return 0;
> +}
> +
> +static int altera_cvp_send_block(struct altera_cvp_conf *conf,
> +				 const u32 *data, size_t len)
> +{
> +	u32 mask, words = len / sizeof(u32);
> +	int i, remainder;
> +
> +	for (i = 0; i < words; i++)
> +		conf->write_data(conf, *data++);
> +
> +	/* write up to 3 trailing bytes, if any */
> +	remainder = len % sizeof(u32);
> +	if (remainder) {
> +		mask = BIT(remainder * 8) - 1;
> +		if (mask)
> +			conf->write_data(conf, *data & mask);
> +	}
> +
> +	return 0;
> +}
> +
>  static int altera_cvp_teardown(struct fpga_manager *mgr,
>  			       struct fpga_image_info *info)
>  {
> @@ -262,39 +297,29 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	return 0;
>  }
>  
> -static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
> -{
> -	struct altera_cvp_conf *conf = mgr->priv;
> -	u32 val;
> -
> -	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
> -	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> -	if (val & VSE_CVP_STATUS_CFG_ERR) {
> -		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
> -			bytes);
> -		return -EPROTO;
> -	}
> -	return 0;
> -}
> -
>  static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>  			    size_t count)
>  {
>  	struct altera_cvp_conf *conf = mgr->priv;
> +	size_t done, remaining, len;
>  	const u32 *data;
> -	size_t done, remaining;
>  	int status = 0;
> -	u32 mask;
>  
>  	/* STEP 9 - write 32-bit data from RBF file to CVP data register */
>  	data = (u32 *)buf;
>  	remaining = count;
>  	done = 0;
>  
> -	while (remaining >= 4) {
> -		conf->write_data(conf, *data++);
> -		done += 4;
> -		remaining -= 4;
> +	while (remaining) {
> +		if (remaining >= sizeof(u32))
> +			len = sizeof(u32);
> +		else
> +			len = remaining;
> +
> +		altera_cvp_send_block(conf, data, len);
> +		data++;
> +		done += len;
> +		remaining -= len;
>  
>  		/*
>  		 * STEP 10 (optional) and STEP 11
> @@ -312,11 +337,6 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>  		}
>  	}
>  
> -	/* write up to 3 trailing bytes, if any */
> -	mask = BIT(remaining * 8) - 1;
> -	if (mask)
> -		conf->write_data(conf, *data & mask);
> -
>  	if (altera_cvp_chkcfg)
>  		status = altera_cvp_chk_error(mgr, count);
>  
> -- 
> 2.7.4
> 
Cheers,
Moritz
