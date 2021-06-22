Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB63AFF40
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Jun 2021 10:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhFVIaf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 04:30:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:62446 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFVIaf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 04:30:35 -0400
IronPort-SDR: LsGPLNPJsgvgkKSomUEPa85txlG6g/l1wOgwBLg0pgzNjKGnn0xoxF55nRAG/nsLtUL9J9p/LZ
 tVcQ30dGtptg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="228565485"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="228565485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 01:28:16 -0700
IronPort-SDR: qC1l6UhWxYj4QjxPSAU8/IDNwTbmvjs7b9YLDqOWtaEMYOo01xQrTjUPWRn2Qwvf5C+fD+7m0t
 eCEQSBKmhVNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="486823448"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2021 01:28:14 -0700
Date:   Tue, 22 Jun 2021 16:23:01 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v6 2/3] fpga: bridge: Use standard dev_release for class
 driver
Message-ID: <20210622082301.GA29169@yilunxu-OptiPlex-7050>
References: <20210621222249.451387-1-russell.h.weight@intel.com>
 <20210621222249.451387-3-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621222249.451387-3-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

2 more comments.

On Mon, Jun 21, 2021 at 03:22:48PM -0700, Russ Weight wrote:
> The FPGA bridge class driver data structure is being treated as a
> managed resource instead of using standard dev_release call-back
> to release the class data structure. This change removes the
> managed resource code and combines the create() and register()
> functions into a single register() function.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v6:
>   - Changed fpga_bridge_register() parameters to accept an info data
>     structure to provide flexibility in passing optional parameters.
>   - Added fpga_bridge_register_simple() function to support current
>     parameters for users that don't require the use of optional
>     parameters.

Add the _simple() description in commit message if needed.

> +struct fpga_bridge *
> +fpga_bridge_register_simple(struct device *dev, const char *name,

			       struct device *parent,

> +			    const struct fpga_bridge_ops *br_ops,
> +			    void *priv);
> +void fpga_bridge_unregister(struct fpga_bridge *br);
>  
>  #endif /* _LINUX_FPGA_BRIDGE_H */
> -- 
> 2.25.1
