Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F96E8C44
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Apr 2023 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjDTIHs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Apr 2023 04:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjDTIHr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Apr 2023 04:07:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E3FB4;
        Thu, 20 Apr 2023 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978066; x=1713514066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=45z54/ft5cKD+j4I8mJozUsKaQJJM7smaN5lpnVufLg=;
  b=LoSiDcmfWB3zRvL6oNlUgZs/h+2rtKTBLTAdm56wFXHh9H8iEma2i6j9
   XGq6lVxPhFj6oS7KyEIjDUYLxKPgP1LiAMdVQ1rSXB3mZapf4KO5OOA8h
   zLnYK0Gu/XF847fVohXTpZFnyB3NhsYW3sWQ1tPfyMBNsEE2/H8MzTBm3
   Hmc5wKLUdGDWcpqVLqHh0PG1tpSwpSYkUP3eZlBgHOeMYR0EC2YvJI5qX
   BaJm6g3NZCSY4+SHfzUz1yWix5oTbJsCuydJ2AjHzQ+etO/GCjXTNjBzX
   1M3n/bKkwvwaHYYVrbp2RwO3Qtwel31IJjpV954yNPQxrC+t+tofS/Daa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="348428645"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="348428645"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="685259099"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="685259099"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2023 01:07:43 -0700
Date:   Fri, 21 Apr 2023 00:08:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mfd: intel-m10-bmc: Move core symbols to own
 namespace
Message-ID: <ZEFjbjijgb37Hhry@yilunxu-OptiPlex-7050>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417092653.16487-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-17 at 12:26:50 +0300, Ilpo Järvinen wrote:
> Create INTEL_M10_BMC_CORE namespace for symbols exported by
> intel-m10-bmc-core.
> 
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/mfd/intel-m10-bmc-core.c | 4 ++--
>  drivers/mfd/intel-m10-bmc-pmci.c | 1 +
>  drivers/mfd/intel-m10-bmc-spi.c  | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
