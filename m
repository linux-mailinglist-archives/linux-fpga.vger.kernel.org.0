Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5217A6E8C54
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Apr 2023 10:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjDTIJi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Apr 2023 04:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjDTIJh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Apr 2023 04:09:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA644AE;
        Thu, 20 Apr 2023 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978173; x=1713514173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8ddX+VmcWmMACs+SZZN/sWFDmJ8vp2NZ3Kdawxtx/cs=;
  b=RFspTM0jluEokWIBuYUG/HAJHJi6k7eyt+wfm8MnyNz3V5eGfHimoIBS
   Bf+Tm9C2C8jZIVRaBD9JwU6sIphEPD+jqP9frk4qUpP1n4RnXCR3SKwNJ
   GREwXCK4dl/oFE4qOJWgLXj/stn03TZk9BExA4K8hZcVvxuPM6LvFXwNL
   lpBa0x2Bi+ro3Pc7s1cU1i4mvoHd2MgDzxRK5v2bsX6ozO3hBdeMTE8IV
   FIZ7EwpfD7dD//ffaM6cQzBq9lIUMRsKU0Mgwg9QjHJWZLMMbEBjROfL1
   LILHpLrWt5D/IlALBd0WrhxO2v4PmQI7/m4lSpNYeKeU+77vssft2ASVi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="344422775"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="344422775"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:09:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803266837"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="803266837"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2023 01:09:29 -0700
Date:   Fri, 21 Apr 2023 00:10:00 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mfd: intel-m10-bmc: Move m10bmc_sys_read() away
 from header
Message-ID: <ZEFj2ImqK7Uk3E/p@yilunxu-OptiPlex-7050>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417092653.16487-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-17 at 12:26:52 +0300, Ilpo Järvinen wrote:
> Move m10bmc_sys_read() out from the header to prepare it for adding
> more code into the function which would make it too large to be a
> static inline any more.
> 
> While at it, replace the vague wording in function comment with more
> precise statements.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net> # For hwmon
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/hwmon/intel-m10-bmc-hwmon.c |  1 +
>  drivers/mfd/intel-m10-bmc-core.c    | 14 ++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h   | 17 +----------------
>  3 files changed, 16 insertions(+), 16 deletions(-)
