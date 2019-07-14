Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9745680D0
	for <lists+linux-fpga@lfdr.de>; Sun, 14 Jul 2019 20:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfGNSqU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 14 Jul 2019 14:46:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33594 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfGNSqT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 14 Jul 2019 14:46:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so6671633pgk.0;
        Sun, 14 Jul 2019 11:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vencji1caUwaH3R36SuIrhKX/+k4CI4F0KZRmbBAkH0=;
        b=jPzFRbYRwllF5+x6K2NhXmtU/O9EYK8W028EoOKUoGmlnu2c2+svPsBFXppDaGE6fk
         fcMiI0r8kNsTcj84lEPefIxV2HfiehPh3ZN7quE3XSJ4zOsfsG7ecz2hbrwXzg0AFH5w
         MGTVJ3xB2DuAkqrR/3Cnqxv2kzIQJO9PkVAw93umv1xMGe+5EhA6zQ/4CV8pqns4Oavb
         QAPfQXEefvG6oFcnpYIYnMJYjsJmsZs1j9y7VcGtmEhGBF+rX0okLxW1k+Z3mhem8USJ
         OpozCSOCzg7UZWscjPEg4rGiMGjI4zTEXEhYx+dDS07PIyGAgP7GRR0Pyh2dlqYULPZt
         gs+A==
X-Gm-Message-State: APjAAAV2kkFedw8kj2oIidls+hxLM8mm77duCxvD6LM024JGe6x5mUCb
        i2EsCTJHetl1AHRtGOrGImo=
X-Google-Smtp-Source: APXvYqxXY/rrLOypg3r7EMB4Sj4v3lC7RPYerKQ8JWEI+4uj10kjD8s4MAztN3Cx4ZwCmr7n96wa+w==
X-Received: by 2002:a63:2148:: with SMTP id s8mr22389558pgm.336.1563129978708;
        Sun, 14 Jul 2019 11:46:18 -0700 (PDT)
Received: from localhost (c-73-15-170-202.hsd1.ca.comcast.net. [73.15.170.202])
        by smtp.gmail.com with ESMTPSA id t10sm14581808pjr.13.2019.07.14.11.46.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 11:46:18 -0700 (PDT)
Date:   Sun, 14 Jul 2019 11:46:17 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] fpga: altera-cvp: Preparation for V2 parts.
Message-ID: <20190714184617.GB9048@archbook>
References: <1562877170-23931-1-git-send-email-thor.thayer@linux.intel.com>
 <1562877170-23931-3-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562877170-23931-3-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Thor,

On Thu, Jul 11, 2019 at 03:32:49PM -0500, thor.thayer@linux.intel.com wrote:
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
>  drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 04f2b2a072a7..59835f6f9b2d 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -140,6 +140,41 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
>  	return -ETIMEDOUT;
>  }
>  
> +static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)

Please drop the inline here.
> +{
> +	struct altera_cvp_conf *conf = mgr->priv;
> +	u32 val;
> +
> +	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
> +	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
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
> +	int i, remainder;
> +	u32 mask, words = len / sizeof(u32);
Reverse xmas-tree, please.
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
>  	const u32 *data;
> -	size_t done, remaining;
> +	size_t done, remaining, len;

Reverse xmas-tree please.
>  	int status = 0;
> -	u32 mask;
>  
>  	/* STEP 9 - write 32-bit data from RBF file to CVP data register */
>  	data = (u32 *)buf;

Are there endianness concerns with this?
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

Thanks,
Moritz
