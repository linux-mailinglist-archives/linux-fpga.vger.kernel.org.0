Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE89D6FDD32
	for <lists+linux-fpga@lfdr.de>; Wed, 10 May 2023 13:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbjEJLvQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 May 2023 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjEJLvP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 10 May 2023 07:51:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AE830F7;
        Wed, 10 May 2023 04:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683719473; x=1715255473;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4b+MbpAx4NSHCwNnjXl8afOivggXQd90E9/dqFkZjWA=;
  b=JD0B5eLfN24e4jNUOkH32QnFgYxYy+4Q2DPttTRaRmfJtXpYrYD5JB7F
   7BHaSyV3PNoZcv+XdZYgxkcFT5fU4x8cQ0Xeud+Vtw0iVVcwH9JrsMkvi
   d6zH0Afe7vyeV856ZIZ7apRuKWEBb4485oRJsWDRLX8AnlCUJKakGLO9R
   C0xlQBFu99yU2knuaVFZqvGv8mdIf3aEHKI1cFnAonV8FOGrTAm4c4zvR
   BsBf8kfHqBGcJb9zg+/y/dhZCIQjFZX5U/vmaBaskujIAD1LifnmlzVSj
   0Kl/tkCVz72Q+YgarR70KkLZ6WcQDS0gp2agjlSN59kYZTAPz2eckRkc0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="339437389"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="339437389"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 04:51:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="768889363"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="768889363"
Received: from sschutze-mobl.ger.corp.intel.com ([10.251.218.236])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 04:51:10 -0700
Date:   Wed, 10 May 2023 14:51:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw
 handshake registers
In-Reply-To: <20230427150712.GV50521@google.com>
Message-ID: <dc53f4a2-b91f-e114-6da8-72cac82d508d@linux.intel.com>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com> <20230417092653.16487-5-ilpo.jarvinen@linux.intel.com> <20230427150712.GV50521@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-958824737-1683719472=:2669"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-958824737-1683719472=:2669
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 27 Apr 2023, Lee Jones wrote:
> On Mon, 17 Apr 2023, Ilpo Järvinen wrote:
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
> > If handshake_sys_reg_nranges == 0, don't update bwcfw_state as it is not
> > used. This avoids the locking cost.
> > 
> > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Co-developed-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/fpga/intel-m10-bmc-sec-update.c | 17 +++++--
> >  drivers/mfd/intel-m10-bmc-core.c        | 67 ++++++++++++++++++++++++-
> >  drivers/mfd/intel-m10-bmc-spi.c         | 14 ++++++
> >  include/linux/mfd/intel-m10-bmc.h       | 28 +++++++++++
> >  4 files changed, 121 insertions(+), 5 deletions(-)
> 
> Applied, thanks

Did these end up falling throught the cracks as I've not been able to 
locate where they were applied?


-- 
 i.

--8323329-958824737-1683719472=:2669--
