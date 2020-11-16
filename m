Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84F92B3B87
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Nov 2020 03:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgKPCwJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 21:52:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:49617 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgKPCwI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 15 Nov 2020 21:52:08 -0500
IronPort-SDR: GghevPs0ZVoMTFCumJWO1sOV7TYaspzFWGQXXM+AWy2Eit+y6JhH4qP02dJw/fe+YjPYAhpAR9
 voVnUrZ7UdjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="168117724"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="168117724"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 18:52:08 -0800
IronPort-SDR: rhloDdjp5KnDURLCiIFjJT4ccNdzWsv87BmTQ0xw6Ehwl0usDK6BmU64f33Vjh5qDhXV1IaQnm
 ltUxgQVuPpCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="358315051"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2020 18:52:06 -0800
Date:   Mon, 16 Nov 2020 10:47:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     richard.gong@linux.intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>, yilun.xu@intel.com
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
  property
Message-ID: <20201116024758.GA6810@yilunxu-OptiPlex-7050>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
 <20201115192106.GB283592@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115192106.GB283592@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Nov 15, 2020 at 11:21:06AM -0800, Moritz Fischer wrote:
> Hi Richard,
> 
> On Thu, Nov 12, 2020 at 12:06:42PM -0600, richard.gong@linux.intel.com wrote:
> > From: Richard Gong <richard.gong@intel.com>
> > 
> > Add authenticate-fpga-config property for FPGA bitstream authentication.
> > 
> > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > ---
> >  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > index e811cf8..7a512bc 100644
> > --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > @@ -187,6 +187,7 @@ Optional properties:
> >  - external-fpga-config : boolean, set if the FPGA has already been configured
> >  	prior to OS boot up.
> >  - encrypted-fpga-config : boolean, set if the bitstream is encrypted
> > +- authenticate-fpga-config : boolean, set if do bitstream authentication
> It is unclear to me from the description whether this entails
> authentication + reconfiguration or just authentication.
> 
> If the latter is the case this should probably be described as such.

If it is just authentication, do we still need to disable bridges in
fpga_region_program_fpga?

I'm wondering if the FPGA functionalities could still be working when
the authenticating is ongoing, or when the authenticating is failed.

Thanks,
Yilun

> 
> >  - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
> >  	bridges to successfully become enabled after the region has been
> >  	programmed.
> > -- 
> > 2.7.4
> > 
> 
> Thanks
