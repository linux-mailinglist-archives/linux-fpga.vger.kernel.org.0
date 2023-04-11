Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DD06DD24F
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Apr 2023 07:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjDKF50 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Apr 2023 01:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDKF5Y (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Apr 2023 01:57:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276AC3A91;
        Mon, 10 Apr 2023 22:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681192610; x=1712728610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EF3DS2gvz2bYEhotwKHn4GGVCCEzg7c8/8/hl25mbs4=;
  b=nT7boguw3zlPBEYBxPmB9IplCdf9PpF+iXPPA14SnLIVpBFxNIGNE9HS
   pCCDzJ68h91BaXDVAZPFDITxCvPHZZlDfJZ+305sNwGgbiVZb1S3WZ+w0
   zeTe56EwtgkEVFvSrg5TewZ44Er69LAp8NPzz0Drv2SdOvBs346UJaVcj
   xHSdXJkVavdsvK7m6HE7UcrscuiOeMFidApRzQnBoFSBYZ9XOuf+UVJSZ
   iz+fIyc6Xb1GytAzjhGPnH1Xmf58rPQBmv3e0t981xxyStoYtFX9gjipH
   OExxUOBQ0/88G3kIMMX5DTi6cHBMnloJn1dsGWEzhqftSAbQE9TGqaAug
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="343535100"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="343535100"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 22:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757692648"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="757692648"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2023 22:56:17 -0700
Date:   Tue, 11 Apr 2023 13:57:00 +0000
From:   Xu Yilun <yilun.xu@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl-fme: constify pointers to hwmon_channel_info
Message-ID: <ZDVnLDpnkycl+Uz8@yilunxu-OptiPlex-7050>
References: <20230407150112.79854-1-krzysztof.kozlowski@linaro.org>
 <0e41f48f-229d-389f-1dec-7230f13e1600@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e41f48f-229d-389f-1dec-7230f13e1600@roeck-us.net>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-07 at 16:08:45 -0700, Guenter Roeck wrote:
> On 4/7/23 08:01, Krzysztof Kozlowski wrote:
> > Statically allocated array of pointed to hwmon_channel_info can be made
> > const for safety.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > This depends on hwmon core patch:
> > https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> > 
> > Therefore I propose this should also go via hwmon tree.
> 
> I am not going to apply patches for 10+ subsystems through the hwmon tree.
> This can only result in chaos. The dependent patch is available at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const
> 
> or wait until after the next commit window to apply this patch.

OK, I could apply this patch to linux-fpga in next cycle.

Thanks,
Yilun

> 
> Thanks,
> Guenter
> 
> > 
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > ---
> >   drivers/fpga/dfl-fme-main.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > index 77ea04d4edbe..bcb5d34b3b82 100644
> > --- a/drivers/fpga/dfl-fme-main.c
> > +++ b/drivers/fpga/dfl-fme-main.c
> > @@ -265,7 +265,7 @@ static const struct hwmon_ops thermal_hwmon_ops = {
> >   	.read = thermal_hwmon_read,
> >   };
> > -static const struct hwmon_channel_info *thermal_hwmon_info[] = {
> > +static const struct hwmon_channel_info * const thermal_hwmon_info[] = {
> >   	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_EMERGENCY |
> >   				 HWMON_T_MAX   | HWMON_T_MAX_ALARM |
> >   				 HWMON_T_CRIT  | HWMON_T_CRIT_ALARM),
> > @@ -465,7 +465,7 @@ static const struct hwmon_ops power_hwmon_ops = {
> >   	.write = power_hwmon_write,
> >   };
> > -static const struct hwmon_channel_info *power_hwmon_info[] = {
> > +static const struct hwmon_channel_info * const power_hwmon_info[] = {
> >   	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT |
> >   				  HWMON_P_MAX   | HWMON_P_MAX_ALARM |
> >   				  HWMON_P_CRIT  | HWMON_P_CRIT_ALARM),
> 
