Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11306C8C45
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Mar 2023 08:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjCYHjI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Mar 2023 03:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCYHjH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 25 Mar 2023 03:39:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5B5267;
        Sat, 25 Mar 2023 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679729947; x=1711265947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sLY1UXi97/Z2gETqW3BWym0tYdxaqZiwmVgNL8H67WA=;
  b=UDNCYjV4Njgyl4CqVpKA3AuJ336+KDpvwZL7LswKYM2XTc52SvbT1FEA
   aRFf/QFUK9zs98b3kVrHiwvfo5WpU1lcAZWKK0qAsdq79ubNr4sHsXoj5
   NwSm3jauQhS1R9MCkPEdkeG35lEdO/FypOgPVsDhUW6/u98lBFM3WUJSR
   HLIbOZICY1BIniOVuoym0BUnHZg4UxYHGV6O1fckkypcPQE10UpiypLZX
   wPZB8QOMgpPQue8EuP+AQY985EvV4Lz9ovDSey9GKfCDtAkgEK9hN8OqD
   ogFQZdt27GF0K1nEJzio8ytz8heUQ73xQnFwnbXHpwvVN4muytQbFzk5o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="341520944"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="341520944"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 00:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="715503495"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="715503495"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 25 Mar 2023 00:39:04 -0700
Date:   Sat, 25 Mar 2023 15:27:36 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] fpga: add fake FPGA bridge
Message-ID: <ZB6iaKEVnVfV3Atl@yilunxu-OptiPlex-7050>
References: <20230310170412.708363-1-marpagan@redhat.com>
 <20230310170412.708363-3-marpagan@redhat.com>
 <ZBQlnUQWZHJ+ZBu5@yilunxu-OptiPlex-7050>
 <988e8e8e-d514-4c69-a384-7d0a70c514c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988e8e8e-d514-4c69-a384-7d0a70c514c4@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-21 at 18:33:05 +0100, Marco Pagani wrote:
> 
> 
> On 2023-03-17 09:32, Xu Yilun wrote:
> > On 2023-03-10 at 18:04:10 +0100, Marco Pagani wrote:
> >> Add fake FPGA bridge driver with support functions. The driver includes
> >> a counter for the number of switching cycles. This module is part of
> >> the KUnit tests for the FPGA subsystem.
> >>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >> ---
> >>  drivers/fpga/tests/fake-fpga-bridge.c | 228 ++++++++++++++++++++++++++
> >>  drivers/fpga/tests/fake-fpga-bridge.h |  36 ++++
> >>  2 files changed, 264 insertions(+)
> >>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
> >>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
> >>
> >> diff --git a/drivers/fpga/tests/fake-fpga-bridge.c b/drivers/fpga/tests/fake-fpga-bridge.c
> >> new file mode 100644
> >> index 000000000000..8a2f64fc1bbb
> >> --- /dev/null
> >> +++ b/drivers/fpga/tests/fake-fpga-bridge.c
> >> @@ -0,0 +1,228 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Driver for the fake FPGA bridge
> >> + *
> >> + * Copyright (C) 2023 Red Hat, Inc.
> >> + *
> >> + * Author: Marco Pagani <marpagan@redhat.com>
> >> + */
> >> +
> >> +#include <linux/types.h>
> >> +#include <linux/device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/fpga/fpga-bridge.h>
> >> +#include <kunit/test.h>
> >> +
> >> +#include "fake-fpga-bridge.h"
> >> +
> >> +#define FAKE_FPGA_BRIDGE_DEV_NAME	"fake_fpga_bridge"
> >> +
> >> +struct fake_bridge_priv {
> >> +	int id;
> >> +	bool enable;
> >> +	int cycles_count;
> >> +	struct kunit *test;
> >> +};
> >> +
> >> +struct fake_bridge_data {
> >> +	struct kunit *test;
> >> +};
> >> +
> >> +static int op_enable_show(struct fpga_bridge *bridge)
> >> +{
> >> +	struct fake_bridge_priv *priv;
> >> +
> >> +	priv = bridge->priv;
> >> +
> >> +	if (priv->test)
> >> +		kunit_info(priv->test, "Fake FPGA bridge %d: enable_show\n",
> >> +			   priv->id);
> > 
> > Why check the kunit pointer every time? I remember you mentioned that
> > the fake fpga modules are expected to be used out of Kunit test, so the
> > priv->test may be NULL? I suggest you work on these usecases in separate
> > patchsets. For now just check priv->test on probe is fine.
> > 
> 
> The idea was to provide additional info messages, tied with the test, if the
> fake bridge is registered with a test instance. If you believe these prints
> are unnecessary, I can remove them or replace them with generic dev_info().

OK, on second thought, it's good to me.

Thanks,
Yilun
