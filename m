Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFAB39E9A9
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 00:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhFGWiJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Jun 2021 18:38:09 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:36384 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFGWiJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Jun 2021 18:38:09 -0400
Received: by mail-pg1-f181.google.com with SMTP id 27so14981369pgy.3;
        Mon, 07 Jun 2021 15:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKhaqCYL8rUWPELYhzsx9BmSwN7L4y5O/8Q3uwiaxlA=;
        b=cCclyaDuIk7Qc0i/e/Qf8bCMg0enIVCSWJgsZ89H09UEUtmhJffIR6VmyC++N/WOLc
         GA5Sitq1kljnykdcco7p9cYfjwg2YQA5TWRWmelrue6HMGBTpWf/OE3o/ARxl8Syv+AK
         xehgRupfv2c4qv4n9g88q7q+ZRblpohDvjO+r9MDvAcLB3FaRjn+AsWadfiNbZNJge54
         MURI1Vk9bczbBLSKa0DCOLd+lpEhB7rpDEPfMsCXWXCnJRJ1v/l3RQHqCfEYlwtOhYmN
         fMiFNKBoBMrbHxAmISRuRnWlqp4vNAct/LwMqws9JSxh4nys/4/ZqXjY2srOfwID4rTj
         o6Sw==
X-Gm-Message-State: AOAM532sa4B/5GeWmPrtx5qXN8BTGiToEaz9nwAjkyvfHuL47XDXuxzE
        OHFMwI1Ki08tRRUuPeCfaZk=
X-Google-Smtp-Source: ABdhPJy/se9L/IQnWLJFUkwmoQhe3Sb8IW9LybQRwl+6bB4lqm3qHNg7etZG3QTmvV4OHCaQbBzvWw==
X-Received: by 2002:a05:6a00:26d8:b029:2ea:1101:8acf with SMTP id p24-20020a056a0026d8b02902ea11018acfmr18694951pfw.67.1623105363086;
        Mon, 07 Jun 2021 15:36:03 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id p20sm8847268pff.204.2021.06.07.15.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 15:36:02 -0700 (PDT)
Date:   Mon, 7 Jun 2021 15:36:01 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/7] fpga: wrap the write_init() op
Message-ID: <YL6fUSD0KLP0l80g@epycbox.lan>
References: <20210607172402.2938697-1-trix@redhat.com>
 <20210607172402.2938697-2-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607172402.2938697-2-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 07, 2021 at 10:23:56AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The board should not be required to provide a
Nit: Can you turn these into for whole series:
A FPGA Manager should not be ...

> write_init() op if there is nothing for it do.
> So add a wrapper and move the op checking.
> Default to success.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/fpga-mgr.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index b85bc47c91a9..24547e36a56d 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -69,6 +69,14 @@ void fpga_image_info_free(struct fpga_image_info *info)
>  }
>  EXPORT_SYMBOL_GPL(fpga_image_info_free);
>  
> +static int fpga_mgr_write_init(struct fpga_manager *mgr,
> +			       struct fpga_image_info *info,
> +			       const char *buf, size_t count)
> +{
> +	if (mgr->mops && mgr->mops->write_init)
> +		return  mgr->mops->write_init(mgr, info, buf, count);
> +	return 0;
> +}
>  /*
>   * Call the low level driver's write_init function.  This will do the
>   * device-specific things to get the FPGA into the state where it is ready to
> @@ -83,9 +91,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  
>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
>  	if (!mgr->mops->initial_header_size)
> -		ret = mgr->mops->write_init(mgr, info, NULL, 0);
> +		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>  	else
> -		ret = mgr->mops->write_init(
> +		ret = fpga_mgr_write_init(
>  		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
>  
>  	if (ret) {
> @@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>  	int id, ret;
>  
>  	if (!mops || !mops->write_complete || !mops->state ||
> -	    !mops->write_init || (!mops->write && !mops->write_sg) ||
> +	    (!mops->write && !mops->write_sg) ||
>  	    (mops->write && mops->write_sg)) {
>  		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
>  		return NULL;
> -- 
> 2.26.3
> 

Can you change the subjects to "fpga: fpga-mgr: ..."

Otherwise series looks good.

- Moritz
