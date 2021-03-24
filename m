Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D1034804B
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhCXSTY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 14:19:24 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:40588 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbhCXSTD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 24 Mar 2021 14:19:03 -0400
Received: by mail-pf1-f179.google.com with SMTP id l3so17934394pfc.7;
        Wed, 24 Mar 2021 11:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWwBAKo7OSsln+88NuXDWmQKbF9I835X1BIrAvwNV4Q=;
        b=tfc22FsiAFvjaVnFY7qrYGI5zr416s9nAVGMLSCnrRA6SXh7r/ClqAxFlLucjKcsyT
         0miYUgHHuvflFT2BggrjJ6ZvtWnbX5mdxmciUJPb3O6deavWbveShW41LMhDwlaiXSH2
         YQqLH7bfo56B/UJUB72eQjpUgHPnyfMbksQkzwY1SpxPAXAo/IZUajf7QCpuPoGwSfdS
         TW0f8t+z8J8ssw7UZePG/sJ1BKZ4fCYTewhkssq2ft4QEjTzQHdIQM8Vq0ShTUOcCMp1
         NBGQp2ANu/g5/7+pRqDUaD3HhWBgvthdtG0IzgOsAJp8GyjuEGTtwIubxovFqL56Umgv
         oxww==
X-Gm-Message-State: AOAM532DaxMVDaN1C/AtwmullqHjjvGvSkqDKqEs1xz78oCsj97CIL2u
        cLbXjKHHPiDclxyoIjx6jCcHWKedqMg=
X-Google-Smtp-Source: ABdhPJypnOYmW1XkgcB36DdSvS5sQ1GnFCnnM0UTiKU8FVmWfkCQuS3hswXqogdBHUcqQ9JiHB0teA==
X-Received: by 2002:a05:6a00:15c4:b029:204:33ea:ced0 with SMTP id o4-20020a056a0015c4b029020433eaced0mr4516014pfu.20.1616609942558;
        Wed, 24 Mar 2021 11:19:02 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x190sm3235312pfx.166.2021.03.24.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 11:19:01 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:19:00 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v9 1/1] fpga: dfl: afu: harden port enable logic
Message-ID: <YFuClO0wzhA89WOX@epycbox.lan>
References: <20210323224650.590392-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323224650.590392-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 23, 2021 at 03:46:50PM -0700, Russ Weight wrote:
> Port enable is not complete until ACK = 0. Change
> __afu_port_enable() to guarantee that the enable process
> is complete by polling for ACK == 0.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v9:
>   - Fix the sense of the if condition in __port_reset()
> v8:
>   - Rebased to 5.12-rc1 (there were no conflicts)
> v7:
>   - Added Acked-by tag from Wu Hao
> v6:
>   - Fixed the dev_warn statement, which had "__func__" embedded in the
>     string instead of treated as a parameter to the format string.
> v5:
>   - Added Reviewed-by tag to commit message
> v4:
>   - Added a dev_warn() call for the -EINVAL case of afu_port_err_clear()
>   - Modified dev_err() message in __afu_port_disable() to say "disable"
>     instead of "reset"
> v3:
>   - afu_port_err_clear() changed to prioritize port_enable failure over
>     other a detected mismatch in port errors.
>   - reorganized code in port_reset() to be more readable.
> v2:
>   - Fixed typo in commit message
> ---
>  drivers/fpga/dfl-afu-error.c | 10 ++++++----
>  drivers/fpga/dfl-afu-main.c  | 35 ++++++++++++++++++++++++-----------
>  drivers/fpga/dfl-afu.h       |  2 +-
>  3 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c4691187cca9..ab7be6217368 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -52,7 +52,7 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>  	struct platform_device *pdev = to_platform_device(dev);
>  	void __iomem *base_err, *base_hdr;
> -	int ret = -EBUSY;
> +	int enable_ret = 0, ret = -EBUSY;
>  	u64 v;
>  
>  	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
> @@ -96,18 +96,20 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>  		v = readq(base_err + PORT_FIRST_ERROR);
>  		writeq(v, base_err + PORT_FIRST_ERROR);
>  	} else {
> +		dev_warn(dev, "%s: received 0x%llx, expected 0x%llx\n",
> +			 __func__, v, err);
>  		ret = -EINVAL;
>  	}
>  
>  	/* Clear mask */
>  	__afu_port_err_mask(dev, false);
>  
> -	/* Enable the Port by clear the reset */
> -	__afu_port_enable(pdev);
> +	/* Enable the Port by clearing the reset */
> +	enable_ret = __afu_port_enable(pdev);
>  
>  done:
>  	mutex_unlock(&pdata->lock);
> -	return ret;
> +	return enable_ret ? enable_ret : ret;
>  }
>  
>  static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 753cda4b2568..7f621e96d3b8 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -21,6 +21,9 @@
>  
>  #include "dfl-afu.h"
>  
> +#define RST_POLL_INVL 10 /* us */
> +#define RST_POLL_TIMEOUT 1000 /* us */
> +
>  /**
>   * __afu_port_enable - enable a port by clear reset
>   * @pdev: port platform device.
> @@ -32,7 +35,7 @@
>   *
>   * The caller needs to hold lock for protection.
>   */
> -void __afu_port_enable(struct platform_device *pdev)
> +int __afu_port_enable(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>  	void __iomem *base;
> @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
>  	WARN_ON(!pdata->disable_count);
>  
>  	if (--pdata->disable_count != 0)
> -		return;
> +		return 0;
>  
>  	base = dfl_get_feature_ioaddr_by_id(&pdev->dev, PORT_FEATURE_ID_HEADER);
>  
> @@ -49,10 +52,20 @@ void __afu_port_enable(struct platform_device *pdev)
>  	v = readq(base + PORT_HDR_CTRL);
>  	v &= ~PORT_CTRL_SFTRST;
>  	writeq(v, base + PORT_HDR_CTRL);
> -}
>  
> -#define RST_POLL_INVL 10 /* us */
> -#define RST_POLL_TIMEOUT 1000 /* us */
> +	/*
> +	 * HW clears the ack bit to indicate that the port is fully out
> +	 * of reset.
> +	 */
> +	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
> +			       !(v & PORT_CTRL_SFTRST_ACK),
> +			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> +		dev_err(&pdev->dev, "timeout, failure to enable device\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
>  
>  /**
>   * __afu_port_disable - disable a port by hold reset
> @@ -86,7 +99,7 @@ int __afu_port_disable(struct platform_device *pdev)
>  	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
>  			       v & PORT_CTRL_SFTRST_ACK,
>  			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
> -		dev_err(&pdev->dev, "timeout, fail to reset device\n");
> +		dev_err(&pdev->dev, "timeout, failure to disable device\n");
>  		return -ETIMEDOUT;
>  	}
>  
> @@ -110,10 +123,10 @@ static int __port_reset(struct platform_device *pdev)
>  	int ret;
>  
>  	ret = __afu_port_disable(pdev);
> -	if (!ret)
> -		__afu_port_enable(pdev);
> +	if (ret)
> +		return ret;
>  
> -	return ret;
> +	return __afu_port_enable(pdev);
>  }
>  
>  static int port_reset(struct platform_device *pdev)
> @@ -872,11 +885,11 @@ static int afu_dev_destroy(struct platform_device *pdev)
>  static int port_enable_set(struct platform_device *pdev, bool enable)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -	int ret = 0;
> +	int ret;
>  
>  	mutex_lock(&pdata->lock);
>  	if (enable)
> -		__afu_port_enable(pdev);
> +		ret = __afu_port_enable(pdev);
>  	else
>  		ret = __afu_port_disable(pdev);
>  	mutex_unlock(&pdata->lock);
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index 576e94960086..e5020e2b1f3d 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -80,7 +80,7 @@ struct dfl_afu {
>  };
>  
>  /* hold pdata->lock when call __afu_port_enable/disable */
> -void __afu_port_enable(struct platform_device *pdev);
> +int __afu_port_enable(struct platform_device *pdev);
>  int __afu_port_disable(struct platform_device *pdev);
>  
>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
> -- 
> 2.25.1
> 
Applied to for-next.

Thanks,
Moritz
