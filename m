Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9560C23C7EF
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Aug 2020 10:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgHEIjf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Aug 2020 04:39:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:46257 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgHEIjf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Aug 2020 04:39:35 -0400
IronPort-SDR: PlVoAU24o2O+fqv2sX6CsxzlkFAx0E9IawDJLi+xqMyBJf5Y/TwrcR+Q5XQ9AmST6ztAY9zOWK
 Q5efib9/ZZLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132053318"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="132053318"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 01:39:34 -0700
IronPort-SDR: guzNlBMCBPFNVze+bJ3F+LvIMVtWCcor+lqNMrTXYz2j/SaFBkfDzuOlQZsPTvdakmfzW48qfb
 D+VxQmMPYeKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="315673885"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2020 01:39:33 -0700
Date:   Wed, 5 Aug 2020 16:36:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private
  feature
Message-ID: <20200805083605.GB20262@yilunxu-OptiPlex-7050>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-5-git-send-email-yilun.xu@intel.com>
 <b5d4157b-1bdf-445c-58a7-abd2f485a5ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d4157b-1bdf-445c-58a7-abd2f485a5ff@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Thanks for the word smith. I'll add these changes.

Thanks,
Yilun

On Tue, Aug 04, 2020 at 11:45:33AM -0700, Tom Rix wrote:
> Some minor edits.
> 
> I have added definitions for fec, kr, and rs.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
> Tom
> 
> > --- /dev/null
> > +++ b/Documentation/fpga/dfl-n3000-nios.rst
> > @@ -0,0 +1,39 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=====================================
> > +DFL N3000 Nios Private Feature Driver
> > +=====================================
> > +
> > +The dfl n3000 nios driver supports for the nios handshake private feature on
> > +Intel N3000 FPGA Card.
> > +
> > +This private feature provides a handshake interface to FPGA NIOS firmware,
> > +which receives the ethernet retimer configuration command from host and
> > +do the configuration via an internal SPI master. When nios finished the
> 
> does the configuration..
> 
> When nios finishes the ..
> 
> > +configuration, host takes over the ownership of the SPI master to control an
> > +Intel MAX10 BMC Chip on the SPI bus.
> > +
> > +So the driver does 2 major tasks on probe, requires NIOS firmware to configure
> , uses the NIOS firmware to configure the ethernet retimer, and then ..
> > +the ethernet retimer by operating the handshake interfaces, and then creates a
> > +spi master platform device with the MAX10 device info in spi_board_info.
> > +
> > +Module Parameters
> > +=================
> > +
> > +The dfl n3000 nios driver supports the following module parameters:
> > +
> > +* fec_mode: string
> > +  Require the NIOS firmware to set the FEC mode of the ethernet retimer on
> the FEC (Forward Error Correction) mode
> > +  the PAC N3000 FPGA card. The possible values could be:
> > +
> > +  - "rs": RS FEC mode (default)
> - "rs" : Reed Solomon FEC (default)
> > +  - "kr": KR FEC mode
> - "kr": Fire Code FEC
> > +  - "no": NO FEC mode
> > +
> > +  The configuration could only be set once after the board powers up, the
> The configuration can only be ..
> > +  firmware will not accept a second configuration afterward. So the fec mode
> second configuration.
> > +  will not be changed if the module is reloaded with a different param value.
> > +
> > +  The configured value of the fec mode could be queried from sysfs node:
> > +
> > +  /sys/bus/dfl/devices/dfl-fme.X.X/fec_mode
