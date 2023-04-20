Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63176E8C4D
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Apr 2023 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjDTIIt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Apr 2023 04:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjDTIIs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Apr 2023 04:08:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7276E10FA;
        Thu, 20 Apr 2023 01:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978125; x=1713514125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zJvun7RpBFxuzLECfz2qxFMSQrcTU4dMCJpc6Mn8Qsg=;
  b=VSINmG1SshZHO7G4uutjNb7njjul6IC+eSzPctbWtC8+3XGuMXzdgjQw
   Q+70k0HClvBIMRtKuggaGXygE/CU3DN+unC4X2eK8Ml3XW5wlPzs0XKhl
   qVbn6y+l6VklyNGLKZD89Hru6EM50lts5a8NTWIzr9jWsS9Y6s9XGT0fJ
   OhuDfh+6M2boQuJxuvN1f1nArSTG8oRQjWlIGrSpJ5xYgRD7bzSg5tYmO
   L7ih21y2UjloQoVMphjRjY/asCACEdJ+mXQ7Dql2RNr45s1V58pD++S2B
   vVsHDFtqMoqATWVdLL6cIcoPQK7PtcQ3ivqA2ua6KJFtjk0CxUSpzER4i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="344422575"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="344422575"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="781157973"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="781157973"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2023 01:08:42 -0700
Date:   Fri, 21 Apr 2023 00:09:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mfd: intel-m10-bmc: Create
 m10bmc_sys_update_bits()
Message-ID: <ZEFjqZdXDYRJdXgp@yilunxu-OptiPlex-7050>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417092653.16487-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-17 at 12:26:51 +0300, Ilpo Järvinen wrote:
> Wrap regmap_update_bits() with m10bmc_sys_update_bits() in order to be
> able to add additional checks into it.
> 
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 30 ++++++++++++-------------
>  drivers/mfd/intel-m10-bmc-core.c        |  9 ++++++++
>  include/linux/mfd/intel-m10-bmc.h       |  4 ++++
>  3 files changed, 27 insertions(+), 16 deletions(-)
