Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD4C2B56B7
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Nov 2020 03:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgKQC3N (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Nov 2020 21:29:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:19890 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgKQC3N (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 21:29:13 -0500
IronPort-SDR: Vo16YMykxqZOAGwG5BxUt95COAAVHopNRSaOH3NS5iWHlhc/hu/FY/z1KTbFUHs41jSO7he+vU
 YAlqm+20H2ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="158624643"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="158624643"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 18:29:05 -0800
IronPort-SDR: Aj04aXMVaFnJd12GjLocklNkx3hmw2yvyRkKElVAxBE4+7ci5C0P0L89EL2lULxCpp1HPhGIlL
 fCdoTHq6BZAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="533638321"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 16 Nov 2020 18:29:02 -0800
Date:   Tue, 17 Nov 2020 10:24:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>, yilun.xu@intel.com
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
  property
Message-ID: <20201117022453.GA12837@yilunxu-OptiPlex-7050>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
 <20201115192106.GB283592@epycbox.lan>
 <20201116024758.GA6810@yilunxu-OptiPlex-7050>
 <d83b37c2-2baa-b366-8ca4-bb2924bcd4f9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83b37c2-2baa-b366-8ca4-bb2924bcd4f9@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Nov 16, 2020 at 08:14:52AM -0600, Richard Gong wrote:
> 
> Hi Yilun,
> 
> On 11/15/20 8:47 PM, Xu Yilun wrote:
> >On Sun, Nov 15, 2020 at 11:21:06AM -0800, Moritz Fischer wrote:
> >>Hi Richard,
> >>
> >>On Thu, Nov 12, 2020 at 12:06:42PM -0600, richard.gong@linux.intel.com wrote:
> >>>From: Richard Gong <richard.gong@intel.com>
> >>>
> >>>Add authenticate-fpga-config property for FPGA bitstream authentication.
> >>>
> >>>Signed-off-by: Richard Gong <richard.gong@intel.com>
> >>>---
> >>>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>>diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> >>>index e811cf8..7a512bc 100644
> >>>--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> >>>+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> >>>@@ -187,6 +187,7 @@ Optional properties:
> >>>  - external-fpga-config : boolean, set if the FPGA has already been configured
> >>>  	prior to OS boot up.
> >>>  - encrypted-fpga-config : boolean, set if the bitstream is encrypted
> >>>+- authenticate-fpga-config : boolean, set if do bitstream authentication
> >>It is unclear to me from the description whether this entails
> >>authentication + reconfiguration or just authentication.
> >>
> >>If the latter is the case this should probably be described as such.
> >
> >If it is just authentication, do we still need to disable bridges in
> >fpga_region_program_fpga?
> >
> 
> Yes.
> 
> Except for the actual configuration of the device, the authentication
> feature is the same as FPGA configuration.

FPGA Bridges gate bus signals between a host and FPGA. So the FPGA
region could not be accessed by host when doing configuration. But for
this authentication, we are just writing the flash, we don't actually
touch the FPGA soft logic. The host should still be able to operate on
the old logic before reboot, is it?

Thanks,
Yilun

> 
> Regards,
> Richard
> 
> >I'm wondering if the FPGA functionalities could still be working when
> >the authenticating is ongoing, or when the authenticating is failed.
> >
> 
> 
> 
> >Thanks,
> >Yilun
> >
> >>
> >>>  - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
> >>>  	bridges to successfully become enabled after the region has been
> >>>  	programmed.
> >>>-- 
> >>>2.7.4
> >>>
> >>
> >>Thanks
