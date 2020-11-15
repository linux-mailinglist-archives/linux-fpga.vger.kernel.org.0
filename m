Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7768E2B38F2
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 21:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgKOUDc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 15:03:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42625 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgKOUDc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 15:03:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id 131so852663pfb.9;
        Sun, 15 Nov 2020 12:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSgzS039n+3PGyt0MXWMRrql06PRL7hk2fw+AHog/6U=;
        b=j7LvDPLUYecUAtgYHJubLbhdaOu6oU6n8gfHV3hCXwp6QQU+wb43ADCmlxyzw35sYw
         bXFlMpTXYC7LuEL3+IJpV0bJa4sKmOXUnEeGY9XCuT0Qx3+sGig/KVmb09RSuJPBj+uD
         Wsoi1rMS5zAtnVm1QV5GcVxTo8XQk0QwROXqjm0yRlVdjk55e9omTlueQHPuUutzHWAQ
         PSme+wOECAimmTiD7ODW+d9FxgQ1WSB01EpwwE5xd1xu7o9H2QTiI78snpegmC6r1tuB
         hn9mrDUx0/dl7TX3zPwvbcpAbeeo6228UjqhmcZ2IJn+sbIbzyEkIxV3kft2S8A4wIpJ
         WxXw==
X-Gm-Message-State: AOAM532Mu05JHCHPZ6VQ/8HT6HK5CJVe49HxNUaIasQT98yXu2QXro1t
        CYYdBWhg5DngMj+jUkAH8Jg=
X-Google-Smtp-Source: ABdhPJwTCovdOfzalSZlErBDSQsDiY+yoRFgw4wclM0ZJkz4wbinMYTp4JAaiW7FQXnVnywAl9u6GA==
X-Received: by 2002:a62:6586:0:b029:164:1cb9:8aff with SMTP id z128-20020a6265860000b02901641cb98affmr11419835pfb.64.1605470611629;
        Sun, 15 Nov 2020 12:03:31 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id t36sm14348354pfg.55.2020.11.15.12.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 12:03:31 -0800 (PST)
Date:   Sun, 15 Nov 2020 12:03:30 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v5 3/6] fpga: m10bmc-sec: expose max10 flash update count
Message-ID: <20201115200330.GA284619@epycbox.lan>
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114005559.90860-4-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Nov 13, 2020 at 04:55:56PM -0800, Russ Weight wrote:
> Extend the MAX10 BMC Secure Update driver to provide a
> sysfs file to expose the flash update count for the FPGA
> user image.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v5:
>   - Renamed sysfs node user_flash_count to flash_count and updated the
>     sysfs documentation accordingly.
> v4:
>   - Moved the sysfs file for displaying the flash count from the
>     FPGA Security Manager class driver to here. The
>     m10bmc_user_flash_count() function is removed and the
>     functionality is moved into a user_flash_count_show()
>     function.
>   - Added ABI documentation for the new sysfs entry
> v3:
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
>     driver"
>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>     underlying functions are now called directly.
> v2:
>   - Renamed get_qspi_flash_count() to m10bmc_user_flash_count()
>   - Minor code cleanup per review comments
>   - Added m10bmc_ prefix to functions in m10bmc_iops structure
> ---
>  .../testing/sysfs-driver-intel-m10-bmc-secure |  8 +++++
>  drivers/fpga/intel-m10-bmc-secure.c           | 34 +++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> index 2992488b717a..73a3aba750e8 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> @@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
>  		"hash not programmed".  This file is only visible if the
>  		underlying device supports it.
>  		Format: "0x%x".
> +
> +What:		/sys/bus/platform/devices/n3000bmc-secure.*.auto/security/flash_count
> +Date:		Oct 2020
> +KernelVersion:  5.11
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read only. Returns number of times the secure update
> +		staging area has been flashed.
> +		Format: "%u".
> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
> index 198bc8273d6b..6ad897001086 100644
> --- a/drivers/fpga/intel-m10-bmc-secure.c
> +++ b/drivers/fpga/intel-m10-bmc-secure.c
> @@ -11,6 +11,7 @@
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  
>  struct m10bmc_sec {
>  	struct device *dev;
> @@ -77,7 +78,40 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>  DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>  
> +#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
> +
> +static ssize_t flash_count_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> +	unsigned int num_bits = FLASH_COUNT_SIZE * 8;
> +	u8 *flash_buf;
> +	int cnt, ret;

(Nit) Can you make this:

	struct m10bmc_sec *sec = dev_get_drvdata(dev);
	unsigned int stride, num_bits;
	u8 *flash_buf;
	int cnt, ret;

	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
	num_bits = FLASH_COUNT_SIZE * 8;


> +
> +	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
> +	if (!flash_buf)
> +		return -ENOMEM;
> +
> +	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
> +			       flash_buf, FLASH_COUNT_SIZE / stride);
> +	if (ret) {
> +		dev_err(sec->dev,
> +			"failed to read flash count: %x cnt %x: %d\n",
> +			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
> +		goto exit_free;
> +	}
> +	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
> +
> +exit_free:
> +	kfree(flash_buf);
> +
> +	return ret ? : sysfs_emit(buf, "%u\n", cnt);
> +}
> +static DEVICE_ATTR_RO(flash_count);
> +
>  static struct attribute *m10bmc_security_attrs[] = {
> +	&dev_attr_flash_count.attr,
>  	&dev_attr_bmc_root_entry_hash.attr,
>  	&dev_attr_sr_root_entry_hash.attr,
>  	&dev_attr_pr_root_entry_hash.attr,
> -- 
> 2.25.1
> 

Otherwise looks good to me,

- Moritz
