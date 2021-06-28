Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1AB3B68BA
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbhF1S4O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 14:56:14 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33330 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhF1S4L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Jun 2021 14:56:11 -0400
Received: by mail-pg1-f172.google.com with SMTP id e20so16270809pgg.0;
        Mon, 28 Jun 2021 11:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KFsdZUIwx1NaT9sJmBFG0+k6XPOLMbP2/QroHIKM5Gk=;
        b=Cmb2minZd0BFH10ctfbKkSA7ugSJWMiq/dq7S5eRUlx8OaeDdT3DzUVugsYj9pDACs
         Uc4JpRQchk5UxU6OVnAi8dEtDTec3hEKFrHRxjDuWUQqeMGX0/9W/6BWKlLI80dV0HX7
         6TLrekwMkhQoC0bVfIeIU6GM2C9Stq119G/W0M03QMxRiCTAlbD1MBeg7BlCVhuyEPKq
         to6r+d1KWWElv2rpFL1f2+FuOprAMVtrP81V0HvP6NdYxg5sUFT3ufXKFf0G4sczWnUk
         rBPGE/BldsqHERaUgpjz8GEm6ztEUTjVcYIt5r+QX3eAl1Mp2dUR5fOPBvLyUc0aBRP0
         7/Ew==
X-Gm-Message-State: AOAM530ySeph+J30IEui2MT/lxCBCb9OMyzjEo+AgWukKaeCPCQVmSBS
        P/PJ+YtDbWqZpp3u7GMAcVE=
X-Google-Smtp-Source: ABdhPJwPIJS5vyR6L0Jv0ewsZPCSstMnN84xP8E7SazZ/DzBYWtMM0Tu0G/0ppjVRP5+NQNy2vbFhQ==
X-Received: by 2002:a62:520e:0:b029:30b:fc21:975d with SMTP id g14-20020a62520e0000b029030bfc21975dmr7939543pfb.57.1624906425848;
        Mon, 28 Jun 2021 11:53:45 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id ft18sm258534pjb.24.2021.06.28.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 11:53:45 -0700 (PDT)
Date:   Mon, 28 Jun 2021 11:53:44 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/7] fpga-mgr: wrap the write_init() op
Message-ID: <YNoauN/c0E65n8JU@epycbox.lan>
References: <20210625195148.837230-1-trix@redhat.com>
 <20210625195148.837230-3-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625195148.837230-3-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 25, 2021 at 12:51:42PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> An FPGA manager should not be required to provide a
> write_init() op if there is nothing for it do.
> So add a wrapper and move the op checking.
> Default to success.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/fpga-mgr.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index ecb4c3c795fa5..c047de8a059b7 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -25,6 +25,15 @@ struct fpga_mgr_devres {
>  	struct fpga_manager *mgr;
>  };
>  
> +static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
> +				      struct fpga_image_info *info,
> +				      const char *buf, size_t count)
> +{
> +	if (mgr->mops->write_init)

Will you need a if (mgr->mops && mgr->mops->write_init) here later?
> +		return  mgr->mops->write_init(mgr, info, buf, count);
> +	return 0;
> +}
> +
>  /**
>   * fpga_image_info_alloc - Allocate an FPGA image info struct
>   * @dev: owning device
> @@ -83,9 +92,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
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
> @@ -569,7 +578,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>  	int id, ret;
>  
>  	if (!mops || !mops->write_complete || !mops->state ||
> -	    !mops->write_init || (!mops->write && !mops->write_sg) ||
> +	    (!mops->write && !mops->write_sg) ||
>  	    (mops->write && mops->write_sg)) {
>  		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
>  		return NULL;
> -- 
> 2.26.3
> 
Looks good to me, I might reword the commit message some when applying.

- Moritz
