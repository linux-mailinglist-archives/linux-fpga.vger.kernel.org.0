Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E740634688A
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Mar 2021 20:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhCWTIW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Mar 2021 15:08:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:27725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232986AbhCWTIP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 23 Mar 2021 15:08:15 -0400
IronPort-SDR: sc+M0yI8vhQ7L/3NiIaFZYPi2JaNR9uRNounlTSLRz1hDTVz4bCEKUI8irYJfNXMjIekOfbrJt
 IZwU6HtcEWVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="187230426"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="187230426"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 12:08:14 -0700
IronPort-SDR: soqaP0mex//dgVJNdkvhAP1GQ+JdwzHG8fy+7Ho7Mm64Qd+QcUvKPx0v4uhpXCgc/AwFBfarAa
 YA0x0JAoPqhg==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="374352926"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.31.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 12:08:13 -0700
Subject: Re: [PATCH v8 1/1] fpga: dfl: afu: harden port enable logic
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20210303014543.68292-1-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <4dac610e-2acd-1385-0ea8-e7f279933a65@intel.com>
Date:   Tue, 23 Mar 2021 12:08:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210303014543.68292-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 3/2/21 5:45 PM, Russ Weight wrote:
> Port enable is not complete until ACK = 0. Change
> __afu_port_enable() to guarantee that the enable process
> is complete by polling for ACK == 0.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
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
>  drivers/fpga/dfl-afu-main.c  | 33 +++++++++++++++++++++++----------
>  drivers/fpga/dfl-afu.h       |  2 +-
>  3 files changed, 30 insertions(+), 15 deletions(-)
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
The sense of the above condition should have been reversed with this reorganization of the code. I'll submit a new patch.

- Russ
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

