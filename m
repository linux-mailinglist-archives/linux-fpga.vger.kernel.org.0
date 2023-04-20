Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A35B6E9274
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Apr 2023 13:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDTLY4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Apr 2023 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjDTLYh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Apr 2023 07:24:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450434EF6;
        Thu, 20 Apr 2023 04:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA7A660EE2;
        Thu, 20 Apr 2023 11:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FBDC433D2;
        Thu, 20 Apr 2023 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681989210;
        bh=83TzyHp1mq1Rphu2Mp/8bCtIaYRo7x0Qx9nQXv5k8Mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mesjctjmh4x2MfVshQziiYcP9VPUja+3n03zFKwjFShgQ5Cuj1r8B9x2Mkyvh7mmI
         yWiQWgHLUGHeOfjEoPQYvX1xAiIFXzYS7kpdu9J1MhagXRDm7Z+9JxA962vSj2DclJ
         kCT5d3rC2cWqMzwbIGNqoP5S4VIyuw5CXn8e+aKEQKgbGku8jQmQn1gGGg/KIe83qe
         kNXANOU+kPd1O/gFoWBhpVwTfV6AW6MeYVWRRTJX7xMSr81paNJOWn7r4hNFP2H+g5
         IqKnuFhBk4W10zfGrGHAHfYJO25bLApSZEj5TCwgcw5rjUm1uIaSgGnJiGPLb1TM3X
         K+XR5jRKXGpug==
Date:   Thu, 20 Apr 2023 12:13:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mfd: intel-m10-bmc: Manage access to MAX 10 fw
 handshake registers
Message-ID: <20230420111324.GA970483@google.com>
References: <20230417092653.16487-1-ilpo.jarvinen@linux.intel.com>
 <20230417092653.16487-5-ilpo.jarvinen@linux.intel.com>
 <ZEFjQtOCQCvQJ1k/@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEFjQtOCQCvQJ1k/@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 21 Apr 2023, Xu Yilun wrote:

> On 2023-04-17 at 12:26:53 +0300, Ilpo Järvinen wrote:
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
> 
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> 
> Hi Lee:
> 
> Could the fpga part also been applied to mfd tree when everyone is good?

Yes, with an Acked-by it can.

-- 
Lee Jones [李琼斯]
