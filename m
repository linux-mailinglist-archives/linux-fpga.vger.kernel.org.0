Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB06DA8FA
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Apr 2023 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbjDGGaG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Apr 2023 02:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbjDGGaF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Apr 2023 02:30:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C949F1;
        Thu,  6 Apr 2023 23:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680849005; x=1712385005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XbIlN7JUWEaT0Orh4Ako5ArMJhLSGp6OwP7MqqoUFBY=;
  b=BupNbpoBMNh3IUX5zsNxyoi4E+t+5+/6/lozM+baihKJmbB+n7tO6oe1
   zx2MHdTiU3hGhnbO2NLugkuonSESVPLmCVpxDxdntn4z1qO1uIX/PIaux
   Tn2xXubajz2Q26xyTrPtfwCVJlXLuq/66T/aBV5vdXtX9UZxMnE6Sk0gc
   h059XuLe1x+uko3ovZ5i80a4jekKQVOJa8RSE4mOi8mYKVGlR6aVGVsWO
   pEHvbq3REC+uEi0rQbMNfH1U9hOv6G2IPcZIPC+TuKYyVnwbbLyOSuOMt
   wu8iXihtUnJMzK1yPBGTYRwUkNcq0p3zGQf11cT/p8ZX4vxd9ERrBKI5T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="370769607"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="370769607"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 23:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="933501919"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="933501919"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 06 Apr 2023 23:30:01 -0700
Date:   Fri, 7 Apr 2023 14:18:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw
 handshake registers
Message-ID: <ZC+1rKoUNsqrjjtw@yilunxu-OptiPlex-7050>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com>
 <20230405080152.6732-5-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230405080152.6732-5-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-05 at 11:01:52 +0300, Ilpo Järvinen wrote:
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
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Co-developed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 17 +++++--
>  drivers/mfd/intel-m10-bmc-core.c        | 63 ++++++++++++++++++++++++-
>  drivers/mfd/intel-m10-bmc-pmci.c        |  4 ++
>  drivers/mfd/intel-m10-bmc-spi.c         | 14 ++++++
>  include/linux/mfd/intel-m10-bmc.h       | 27 +++++++++++
>  5 files changed, 120 insertions(+), 5 deletions(-)
>

[...]
 
>  
> +void m10bmc_fw_state_set(struct intel_m10bmc *m10bmc, enum m10bmc_fw_state new_state)
> +{
> +	down_write(&m10bmc->bmcfw_lock);
> +	m10bmc->bmcfw_state = new_state;
> +	up_write(&m10bmc->bmcfw_lock);

Could we also skip this if no handshake is possible like for PMCI?

Thanks,
Yilun
