Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1623E31200D
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Feb 2021 21:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBFUqv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Feb 2021 15:46:51 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:39535 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBFUqu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Feb 2021 15:46:50 -0500
Received: by mail-pj1-f42.google.com with SMTP id d2so5745493pjs.4;
        Sat, 06 Feb 2021 12:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WzrZL2XMTEn7bkOUsNN1sx1v9uLLwH7Gc/tIhKE1Vx8=;
        b=f3GW66rhTQNMCCAyJQ5VGx8WzybpisyHzy1epswZ1+5liv0i4i/46yd581qX+9jdkV
         vFGIm1Y5k+omBFLAZ0UIRVvon8vJMqeozGWCFmY3iGVnfvAMbr93alpQSvFT7s8LmwgK
         hodeIzqbth5b0USLNgFSxQ5Zov8m/uqHyM6EVV6Qtt34hZKlNdR84DMl3yigmS5cRNJP
         Fg0IUKTmL1++u2ibrBcvwF0AieVs6D9aKruMLkRG7EaHrmYTaUq6xp6XKZRPNRy5htBN
         aajsYrcItqVqoRuKTd4W+d3PVXzSvMLYh2kbhY5RbfLeXEHj28Q4JZEUGXmsDC8dAu/I
         ImRA==
X-Gm-Message-State: AOAM532PJDueAi0R+nx1rKDX9Z/MtAYEzvyw4jUfqhhgCTQpwsvhg4nS
        i6Qi13oUYFg587qprMe1FM8=
X-Google-Smtp-Source: ABdhPJzu14s2V+gWNmsgQN72q2OpSHs5fyodoooul9feRHL+YvokUOJdDZ9zWcd3c/MuqFIa8nB/FA==
X-Received: by 2002:a17:902:ecc1:b029:e1:93ab:1e7b with SMTP id a1-20020a170902ecc1b02900e193ab1e7bmr7250872plh.61.1612644369466;
        Sat, 06 Feb 2021 12:46:09 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id s9sm13438902pfd.38.2021.02.06.12.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 12:46:08 -0800 (PST)
Date:   Sat, 6 Feb 2021 12:46:07 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v5 1/1] fpga: dfl: afu: harden port enable logic
Message-ID: <YB8AD46GfmVpC7xh@epycbox.lan>
References: <20210205182521.275887-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205182521.275887-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Russ,

On Fri, Feb 05, 2021 at 10:25:21AM -0800, Russ Weight wrote:
> Port enable is not complete until ACK = 0. Change
> __afu_port_enable() to guarantee that the enable process
> is complete by polling for ACK == 0.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
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
>  drivers/fpga/dfl-afu-main.c  | 33 +++++++++++++++++++++++----------
>  drivers/fpga/dfl-afu.h       |  2 +-
>  3 files changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index c4691187cca9..601e599fc33d 100644
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
> +		dev_warn(dev, "__func__: received 0x%llx, expected 0x%llx\n",
> +			 v, err);
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

Help me understand (sorry if I'm slow here ...), you set ret to -EINVAL,
but then we only care if enabling the port worked?

I'm not sure I follow the logic (doesn't mean it's wrong :) ).
>  }
>  
>  static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 753cda4b2568..77dadaae5b8f 100644
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
> @@ -111,9 +124,9 @@ static int __port_reset(struct platform_device *pdev)
>  
>  	ret = __afu_port_disable(pdev);
>  	if (!ret)
> -		__afu_port_enable(pdev);
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

Thanks,
Moritz
