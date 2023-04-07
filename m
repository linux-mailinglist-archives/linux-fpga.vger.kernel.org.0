Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB76DA8D9
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Apr 2023 08:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjDGGWT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Apr 2023 02:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjDGGWS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Apr 2023 02:22:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2B0197;
        Thu,  6 Apr 2023 23:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680848538; x=1712384538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4TqWjWh9StyjGPJ6nBQV26NfVy8IFel1LdqBAgI8yLs=;
  b=BU/Rr8nQHj1PMoPK/3pCjHgmthwz0GrhmZp+YLBMDrqlavqODQT+Pn6A
   na01Zrs1OJjPgA+KyR8/CvjYfAEAvbCedB8WCnfW/kBHE3sE+n2S5zsCP
   rn8ANBNBR/wRPYCw+C9BttiKGR6/iFcjXGl1pcUpv9ZVMFeH02cSMT7Hz
   L/U3h1EOh3qwEqOrhmYqhLzo22ngO3HracweKpNLxc9Mxg+UutRGVEhts
   ITcUJW3lBQ0AaTlKfuN6is5rLgL+KFgzhB7WgNszycaX3e2BwU1862EtN
   I0eC1yoJy1XHWqRE6HnhcQkO1VSx32Q+xGto3p+KxrKWq3uweud74NNDm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="344705150"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="344705150"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 23:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861697968"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="861697968"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 23:22:13 -0700
Date:   Fri, 7 Apr 2023 14:10:31 +0800
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
Message-ID: <ZC+z16LvAxxyRSg/@yilunxu-OptiPlex-7050>
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
> +static const struct regmap_range null_fw_handshake_regs[0];
> +
>  static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
>  	.base = M10BMC_N6000_SYS_BASE,
>  	.build_version = M10BMC_N6000_BUILD_VER,
> @@ -375,6 +377,8 @@ static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
>  static const struct intel_m10bmc_platform_info m10bmc_pmci_n6000 = {
>  	.cells = m10bmc_pmci_n6000_bmc_subdevs,
>  	.n_cells = ARRAY_SIZE(m10bmc_pmci_n6000_bmc_subdevs),
> +	.handshake_sys_reg_ranges = null_fw_handshake_regs,
> +	.handshake_sys_reg_nranges = 0,

Not sure why a zero length array is needed? Could we just remove
these 2 lines?

Thanks,
Yilun
