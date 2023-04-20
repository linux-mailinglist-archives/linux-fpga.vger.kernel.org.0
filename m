Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D196E8C3A
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Apr 2023 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjDTIHF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Apr 2023 04:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjDTIHE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Apr 2023 04:07:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755C513E;
        Thu, 20 Apr 2023 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681978023; x=1713514023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IWgTUakXo/so+EUi19BYPXwPdQE5MJLPRo4AH1Tqv8E=;
  b=cQE1FGXcUVrkTgHsGSiISeQ0nqDmYKpsqGdNvNYemb9tG+C+/Rl5+hfx
   g/q3wJYommZ+9B2aSmF7YNofc2EC7Z/TlR1ikEY3hnAsHl1MziEfAade2
   BUZ4v0Qk3bZOpjV/uWytXTQYwJkLstWRW7Cwk7ispJnzl77zBLXt+DXo+
   f2qHnkjn22mCXKXNAEolK8cFBiPOR4/r3uWF10EJYfc7V7roZ6SPAsy0+
   uybKe16+o8O5A6SJuLyuJ92w8v618NTtGOvSAcfxGPB4Cs2f1L267ZnQa
   amoZRZPjupPEFY+iqvMVB0VL7MKL0WYV6XodXZvkRVkJoitXmFC2NJfju
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334494756"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="334494756"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="722283330"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="722283330"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2023 01:06:59 -0700
Date:   Fri, 21 Apr 2023 00:07:30 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw
 handshake registers
Message-ID: <ZEFjQtOCQCvQJ1k/@yilunxu-OptiPlex-7050>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417092653.16487-5-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-17 at 12:26:53 +0300, Ilpo Järvinen wrote:
> On some MAX 10 cards, the BMC firmware is not available to service
> handshake registers during secure update erase and write phases at
> normal speeds. This problem affects at least hwmon driver. When the MAX
> 10 hwmon driver tries to read the sensor values during a secure update,
> the reads are slowed down (e.g., reading all D5005 sensors takes ~24s
> which is magnitudes worse than the normal <0.02s).
> 
> Manage access to the handshake registers using a rw semaphore and a FW
> state variable to prevent accesses during those secure update phases
> and return -EBUSY instead.
> 
> If handshake_sys_reg_nranges == 0, don't update bwcfw_state as it is not
> used. This avoids the locking cost.
> 
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Co-developed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Hi Lee:

Could the fpga part also been applied to mfd tree when everyone is good?

Thanks,
Yilun

> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 17 +++++--
>  drivers/mfd/intel-m10-bmc-core.c        | 67 ++++++++++++++++++++++++-
>  drivers/mfd/intel-m10-bmc-spi.c         | 14 ++++++
>  include/linux/mfd/intel-m10-bmc.h       | 28 +++++++++++
>  4 files changed, 121 insertions(+), 5 deletions(-)
