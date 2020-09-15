Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA9269CC7
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 05:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIOD7O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 23:59:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45632 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIOD7L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Sep 2020 23:59:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh1so638180plb.12;
        Mon, 14 Sep 2020 20:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChIt+4XbVK6bkdfODPwdU9bTaJkdQy5kX/DrjwPR7+s=;
        b=dHWqRm+zV2HYTCNGn2GqJVpo5jdAGc++Vi4T2Md9ErJfXOfu75lpRSNb5JXqr3zei6
         yQLHrRzQPUOXorgyhapR+WWCmmebE05AZBtmB0eip2n8iFv+Hj9SrU7DkP0PRwhL8mIz
         S5pvvVPmLChL0wCXiMngI6fesX/7mfMwbj9yLZLyDPEfQ4D+k8Luf19ESOoxz/e2GJE1
         Pbhw2sFS9IDp1dNRx9UHY41FIj+tO25l9mFio+DouhVuZsfY2yVrujSSh9UFaHhamiax
         5adOYLom9q4nXYvyATmNLwX0Ejsi4QfVv9Jw4bpctWxxEBZWLcyxvyLMG9IiBDgvMDfe
         R0YQ==
X-Gm-Message-State: AOAM533Q5HuOjMo+JkyRzfnwydIH3xxtLClWQcLklxaPHXe1UjXov8qc
        XUjRggJ8qiAVsKQ+QdFC1Sk=
X-Google-Smtp-Source: ABdhPJzgBGqACK+IsJ3thrIlXmTmAlxUUxBB32BuAKD/P2avn5zkU7mY0rboZpcQNasVfyLI8pID5A==
X-Received: by 2002:a17:902:9b82:: with SMTP id y2mr16894824plp.153.1600142350454;
        Mon, 14 Sep 2020 20:59:10 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 84sm11767120pfw.14.2020.09.14.20.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:59:09 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:59:09 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2 1/4] fpga: dfl: move dfl_device_id to mod_devicetable.h
Message-ID: <20200915035909.GA2217@epycbox.lan>
References: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
 <1600140473-12351-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600140473-12351-2-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 15, 2020 at 11:27:50AM +0800, Xu Yilun wrote:
> In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> patch moves struct dfl_device_id to mod_devicetable.h
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: fix the order for the header file
> ---
>  drivers/fpga/dfl.h              | 13 +------------
>  include/linux/mod_devicetable.h | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5dc758f..3c69596 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -22,6 +22,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
> @@ -526,18 +527,6 @@ enum dfl_id_type {
>  };
>  
>  /**
> - * struct dfl_device_id -  dfl device identifier
> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> - * @driver_data: driver specific data.
> - */
> -struct dfl_device_id {
> -	u8 type;
> -	u16 feature_id;
> -	unsigned long driver_data;
> -};
> -
> -/**
>   * struct dfl_device - represent an dfl device on dfl bus
>   *
>   * @dev: generic device interface.
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 5b08a47..407d8dc 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -838,4 +838,16 @@ struct mhi_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> +/**
> + * struct dfl_device_id -  dfl device identifier
> + * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> + * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> + * @driver_data: driver specific data.
> + */
> +struct dfl_device_id {
> +	__u8 type;
> +	__u16 feature_id;
> +	kernel_ulong_t driver_data;
> +};
> +
>  #endif /* LINUX_MOD_DEVICETABLE_H */
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks
