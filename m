Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0C6DDA23
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Apr 2023 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjDKLy6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Apr 2023 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDKLy5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Apr 2023 07:54:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FDEE67;
        Tue, 11 Apr 2023 04:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681214096; x=1712750096;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=C8TGZFhmbYFm4VBWTD8elks6yBJ/GjsydWyFRQRkG+k=;
  b=ko+3sF1vlYNwuLeWcd2oSYbURWxLIMSaZ81N61TulHIZVVWsURamrqgY
   7V81iSBHPJsv5iCjPvIFk/aUm0GeAtqPFQFU+2LwSEZWWB0yYjkOB8yBd
   Y3kpXN2lf3U7txp6lKVS6L5d3J5CJ0B7PDvCmo6PZcvg/oBlAUWrxIORi
   0VgC6ddHqfb/C47gotW0xHug4PwSk4RhWGPiqo8c3V34q+Rz17cqH+Kkx
   wrCo4Z+m+L/8ZPPUqxhULsmnwRwgLYLGCDZmpyJUYX2rGfi1ZG3yUkZ7v
   gj3RZdH1i7vz0pye+3OrgCvt96ZjrDFW6gkK4Arr/QueeYASv4gi8+sG/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341087922"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341087922"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="832314039"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="832314039"
Received: from rwambsga-mobl.ger.corp.intel.com ([10.251.212.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 04:54:53 -0700
Date:   Tue, 11 Apr 2023 14:54:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw
 handshake registers
In-Reply-To: <ZC+1rKoUNsqrjjtw@yilunxu-OptiPlex-7050>
Message-ID: <fb95c8da-c828-12b8-aae-56bd867cff41@linux.intel.com>
References: <20230405080152.6732-1-ilpo.jarvinen@linux.intel.com> <20230405080152.6732-5-ilpo.jarvinen@linux.intel.com> <ZC+1rKoUNsqrjjtw@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1451428716-1681214103=:2109"
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1451428716-1681214103=:2109
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 7 Apr 2023, Xu Yilun wrote:

> On 2023-04-05 at 11:01:52 +0300, Ilpo Järvinen wrote:
> > On some MAX 10 cards, the BMC firmware is not available to service
> > handshake registers during secure update erase and write phases at
> > normal speeds. This problem affects at least hwmon driver. When the MAX
> > 10 hwmon driver tries to read the sensor values during a secure update,
> > the reads are slowed down (e.g., reading all D5005 sensors takes ~24s
> > which is magnitudes worse than the normal <0.02s).
> > 
> > Manage access to the handshake registers using a rw semaphore and a FW
> > state variable to prevent accesses during those secure update phases
> > and return -EBUSY instead.
> > 
> > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Co-developed-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/fpga/intel-m10-bmc-sec-update.c | 17 +++++--
> >  drivers/mfd/intel-m10-bmc-core.c        | 63 ++++++++++++++++++++++++-
> >  drivers/mfd/intel-m10-bmc-pmci.c        |  4 ++
> >  drivers/mfd/intel-m10-bmc-spi.c         | 14 ++++++
> >  include/linux/mfd/intel-m10-bmc.h       | 27 +++++++++++
> >  5 files changed, 120 insertions(+), 5 deletions(-)
> >
> 
> [...]
>  
> >  
> > +void m10bmc_fw_state_set(struct intel_m10bmc *m10bmc, enum m10bmc_fw_state new_state)
> > +{
> > +	down_write(&m10bmc->bmcfw_lock);
> > +	m10bmc->bmcfw_state = new_state;
> > +	up_write(&m10bmc->bmcfw_lock);
> 
> Could we also skip this if no handshake is possible like for PMCI?

Did you mean guarding it with !m10bmc->info->handshake_sys_reg_nranges ?
If yes, it's doable (+ I'd add comment mentioning it since it's slightly 
trappy to not always have that state updated).


-- 
 i.

--8323329-1451428716-1681214103=:2109--
