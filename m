Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26EE25F316
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Sep 2020 08:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIGGSD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Sep 2020 02:18:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:25459 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgIGGSC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 7 Sep 2020 02:18:02 -0400
IronPort-SDR: kOzx9rGF0lldAjmS/hZPXVKAM6g4QFaY5mrksv3WWzNpb1SvUQ9DzP3/IhtgXG9f7+Wx/3iOad
 aAxyfNi2ggPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="157223278"
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="157223278"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 23:18:02 -0700
IronPort-SDR: kh1PkqapkA7fkppLo2m6wFEwd/SbarjPg+s3yoRnP7nFh4j6xyrXtcg9mLno842V7fOXMGEtO9
 ddkbdLh3gl8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="299341122"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 06 Sep 2020 23:18:00 -0700
Date:   Mon, 7 Sep 2020 14:13:48 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v7 3/3] fpga: dfl: add support for N3000 Nios private
  feature
Message-ID: <20200907061348.GA10039@yilunxu-OptiPlex-7050>
References: <1597823121-26424-1-git-send-email-yilun.xu@intel.com>
 <1597823121-26424-4-git-send-email-yilun.xu@intel.com>
 <20200905004512.GC3157@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905004512.GC3157@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Sep 04, 2020 at 05:45:12PM -0700, Moritz Fischer wrote:
> Hi Xu,
> 
> On Wed, Aug 19, 2020 at 03:45:21PM +0800, Xu Yilun wrote:
> > This patch adds support for the Nios handshake private feature on Intel
> > PAC (Programmable Acceleration Card) N3000.
> > 
> > The Nios is the embedded processor on the FPGA card. This private feature
> > provides a handshake interface to FPGA Nois firmware, which receives
> FPGA *NIOS* or *Nios* I think ;-)

Thanks for catching the misspelling.

> > +Configuring the ethernet retimer
> > +================================
> > +
> > +The Intel PAC N3000 is a FPGA based SmartNIC platform which could be programmed
> > +to various configurations (with different link numbers and speeds, e.g. 8x10G,
> > +4x25G ...). And the retimer chips should also be configured correspondingly by
> > +Nios firmware. There are 2 retimer chips on the board, each of them supports 4
> > +links. For example, in 8x10G configuration, the 2 retimer chips are both set to
> > +4x10G mode, while in 4x25G configuration, retimer A is set to 4x25G and retimer
> > +B is in reset. For now, the Nios firmware only supports 10G and 25G mode
> > +setting for the retimer chips.
> Make sure your API above exposes all of that.

Yes. I could add the sysfs interfaces for query of the retimer mode.

> > +Sysfs Attributes
> > +================
> > +
> > +The driver creates the sysfs file in /sys/bus/dfl/devices/dfl_dev.X/
> > +
> > +* fec_mode:
> > +  Read-only. It shows the FEC mode of the 25G links of the ethernet retimers.
> > +  The possible values are the same as the fec_mode module parameter. An extra
> > +  value "not supported" is returned if firmware version major < 3, or no link
> > +  is configured to 25G.
> 
> This seems somewhat duplicate, runs the risk to get out of sync with the
> ABI doc?

Yes. I could just reference the file in Documentation/ABI

> > +static ssize_t fec_mode_show(struct device *dev,
> > +			     struct device_attribute *attr, char *buf)
> > +{
> > +	struct n3000_nios *ns = dev_get_drvdata(dev);
> > +	unsigned int val, retimer_a_mode, retimer_b_mode, fec_mode;
> Can you make this reverse x-mas tree if possible?

Yes, I'll change it.

> > +static int init_error_detected(struct n3000_nios *ns)
> Do you want to make the function either bool, or the return values ints?

I can make it bool.

> > +{
> > +	unsigned int val;
> > +
> > +	if (regmap_read(ns->regmap, PKVL_A_MODE_STS, &val))
> > +		return true;
> > +
> > +	if (!IS_MODE_STATUS_OK(val))
> > +		return true;
> > +
> > +	if (regmap_read(ns->regmap, PKVL_B_MODE_STS, &val))
> > +		return true;
> > +
> > +	if (!IS_MODE_STATUS_OK(val))
> > +		return true;
> > +
> > +	return false;
> > +}

> > +	if (val == 0) {
> > +		dev_err(dev, "Nios version reg = 0x%x, skip INIT_DONE check, but the retimer may be uninitialized\n",
> This looks long, any chance you can linebreak this?

I tried to break the line by
	dev_err(dev, "XXX"
		"XXX", val);

But checkpatch says "WARNING: quoted string split across lines".

I see checkpatch allows long lines for logging functions, so could we
keep it unchanged?

> > +struct spi_board_info m10_n3000_info = {
> > +	.modalias = "m10-n3000",
> Did I miss the patch for this, or did this only go to the SPI folks?

I didn't send the MAX 10 patchset in fpga domain, It goes to the SPI &
MFD maintainers, please see:
	https://lkml.org/lkml/2020/8/19/172

The regmap-spi-avmm has been applied for linux-next. The MAX 10 base
driver is under review.

> > +	.max_speed_hz = 12500000,
> > +	.bus_num = 0,
> > +	.chip_select = 0,
> > +};

Thanks,
Yilun.
