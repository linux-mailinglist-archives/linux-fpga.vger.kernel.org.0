Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D8A3B6C26
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Jun 2021 03:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhF2Bsr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 21:48:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:55188 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230339AbhF2Bsr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 21:48:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="271923306"
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; 
   d="scan'208";a="271923306"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 18:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; 
   d="scan'208";a="492527444"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jun 2021 18:46:17 -0700
Date:   Tue, 29 Jun 2021 09:40:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hwmon: intel-m10-bmc-hwmon: add n5010 sensors
Message-ID: <20210629014058.GB85916@yilunxu-OptiPlex-7050>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-6-martin@geanix.com>
 <20210628163556.GB445250@roeck-us.net>
 <YNoGvOhMQHsqXWfc@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNoGvOhMQHsqXWfc@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 28, 2021 at 10:28:28AM -0700, Moritz Fischer wrote:
> Hi Guenter,
> 
> On Mon, Jun 28, 2021 at 09:35:56AM -0700, Guenter Roeck wrote:
> > On Fri, Jun 25, 2021 at 09:42:13AM +0200, Martin Hundebøll wrote:
> > > From: Martin Hundebøll <mhu@silicom.dk>
> > > 
> > > Add the list of sensors supported by the Silicom n5010 PAC, and enable
> > > the drivers as a subtype of the intel-m10-bmc multi-function driver.
> > > 
> > > Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> > 
> > For my reference:
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Thanks,
Yilun

> 
> > 
> > Not sure if I can apply this patch as-is to hwmon, or if it needs
> > to wait for the other patches in the series. Any thoughts / comments ?
> 
> I don't see how it would break anything in itself since it just adds
> extra compatible and data.
> 
> I'd probably wait with applying until discussions around the mfd and dfl
> parts are resolved since otherwise there's no user.
> 
> > Guenter
> 
> Thanks,
> Moritz
