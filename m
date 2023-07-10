Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6B74CD65
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjGJGmf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 02:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjGJGmW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 02:42:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46420E42;
        Sun,  9 Jul 2023 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688971335; x=1720507335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FSxjv6tOVt1cY5embdGgUoGK0RkYGsxfwCC8aHTYdKc=;
  b=esOM8VMNI3cl5BWYt+TZHdvEmfMoeGizrO42Q117fITm+rJdA6yZM4hd
   MJ1s2w4LeHEm8gzmWTWDZ2G9cKmfcsg2FFtTpQjmd/rT9V+AtIAI6xk3g
   yn7xg7olmNmw6Ut9IJ2a3W19fVGsPs7EsYjUvbYv+7/7WWnSnwBANo7yg
   9AdaUO7Ef6hD3Kpkn/bxJe89NPyAPtdMCuBBBykZKWLoJ7eM1WsdIr5cb
   JyhyhtffnQocStsP80mxBZ4A5Hc8pOOQlD+qH8XOxgMECDf1SIqbOien5
   U8xfRbbIfS8dVt81/8A4vmlWwsV44DVgSp55tTUp61hJaFsTlxYTzdqb8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="361737559"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="361737559"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="755885487"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="755885487"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2023 23:42:10 -0700
Date:   Mon, 10 Jul 2023 14:40:43 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Peter Colberg <peter.colberg@intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com
Subject: Re: [PATCH] fpga: dfl: fme: use SI unit prefix macros
Message-ID: <ZKun6/YT4qGQ26Y1@yilunxu-OptiPlex-7050>
References: <20230705033548.10737-1-peter.colberg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230705033548.10737-1-peter.colberg@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-04 at 23:35:48 -0400, Peter Colberg wrote:
> Substitute SI prefixes MILLI for temperature and MICRO for power, which
> are exported via the hwmon sysfs interface in m°C and ųW, respectively.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> ---
>  drivers/fpga/dfl-fme-main.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index bcb5d34b3b82..3dcf990bd261 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -19,6 +19,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/uaccess.h>
> +#include <linux/units.h>
>  #include <linux/fpga-dfl.h>
>  
>  #include "dfl.h"
> @@ -231,19 +232,19 @@ static int thermal_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  	switch (attr) {
>  	case hwmon_temp_input:
>  		v = readq(feature->ioaddr + FME_THERM_RDSENSOR_FMT1);
> -		*val = (long)(FIELD_GET(FPGA_TEMPERATURE, v) * 1000);
> +		*val = (long)(FIELD_GET(FPGA_TEMPERATURE, v) * MILLI);
>  		break;
>  	case hwmon_temp_max:
>  		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> -		*val = (long)(FIELD_GET(TEMP_THRESHOLD1, v) * 1000);
> +		*val = (long)(FIELD_GET(TEMP_THRESHOLD1, v) * MILLI);
>  		break;
>  	case hwmon_temp_crit:
>  		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> -		*val = (long)(FIELD_GET(TEMP_THRESHOLD2, v) * 1000);
> +		*val = (long)(FIELD_GET(TEMP_THRESHOLD2, v) * MILLI);
>  		break;
>  	case hwmon_temp_emergency:
>  		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> -		*val = (long)(FIELD_GET(TRIP_THRESHOLD, v) * 1000);
> +		*val = (long)(FIELD_GET(TRIP_THRESHOLD, v) * MILLI);
>  		break;
>  	case hwmon_temp_max_alarm:
>  		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> @@ -382,15 +383,15 @@ static int power_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  	switch (attr) {
>  	case hwmon_power_input:
>  		v = readq(feature->ioaddr + FME_PWR_STATUS);
> -		*val = (long)(FIELD_GET(PWR_CONSUMED, v) * 1000000);
> +		*val = (long)(FIELD_GET(PWR_CONSUMED, v) * MICRO);
>  		break;
>  	case hwmon_power_max:
>  		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> -		*val = (long)(FIELD_GET(PWR_THRESHOLD1, v) * 1000000);
> +		*val = (long)(FIELD_GET(PWR_THRESHOLD1, v) * MICRO);
>  		break;
>  	case hwmon_power_crit:
>  		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> -		*val = (long)(FIELD_GET(PWR_THRESHOLD2, v) * 1000000);
> +		*val = (long)(FIELD_GET(PWR_THRESHOLD2, v) * MICRO);
>  		break;
>  	case hwmon_power_max_alarm:
>  		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> @@ -415,7 +416,7 @@ static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
>  	int ret = 0;
>  	u64 v;
>  
> -	val = clamp_val(val / 1000000, 0, PWR_THRESHOLD_MAX);
> +	val = clamp_val(val / MICRO, 0, PWR_THRESHOLD_MAX);
>  
>  	mutex_lock(&pdata->lock);
>  
> -- 
> 2.28.0
> 
