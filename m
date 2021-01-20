Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7BC2FC88E
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Jan 2021 04:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbhATDNi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jan 2021 22:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbhATDN2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Jan 2021 22:13:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5A9C061575;
        Tue, 19 Jan 2021 19:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=vvM9btkTQNOu/hKw67EJEaLpQ+Rj0jHp6wAksUn1bSg=; b=c+VoL9VuPNrY4hUsFLX01+gOd2
        EoKFwb0R1pX+K7PJSHOvSIlcHf1OTXK1fUfci1AEKAXSNhEy8WnNGvtn0yOvJfqiI3Oy1offduS4S
        ALy9FQn4DSIy08i1vxPbeylcxxcN+XwSytQMw9GAF6fFYsK86RA5MEYBOXUhz4nfGMiMFzUB3JivX
        tYXnndu1dfHOO4ttFPFS2P4w40DQd06K4DCs+2N2HfWWmQxb/MwgfrvapVY1CQ1CMtGxdliie/J+0
        RGo9xDzOpHgO3bqvMU0VCylPG438tl54F8vzfamkSnubB65bSSwzYbghTzKmC7yPjAZVC7xqei5By
        I7t9vdDg==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l23v4-0005Sz-DG; Wed, 20 Jan 2021 03:12:30 +0000
Subject: Re: [PATCH v7 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com
References: <1611110606-10380-1-git-send-email-yilun.xu@intel.com>
 <1611110606-10380-3-git-send-email-yilun.xu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4230b792-71e9-842d-ebdf-ad8bac8e11ef@infradead.org>
Date:   Tue, 19 Jan 2021 19:12:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1611110606-10380-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Doc suggestions:

On 1/19/21 6:43 PM, Xu Yilun wrote:
> This patch adds description for UIO support for dfl devices on DFL
> bus.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: no doc in v1, add it for v2.
> v3: some documentation fixes.
> v4: documentation change since the driver matching is changed.
> v5: no change.
> v6: improve the title of the userspace driver support section.
>     some word improvement.
> v7: rebased to next-20210119
> ---
>  Documentation/fpga/dfl.rst | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index c41ac76..f96a6fb 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -7,6 +7,7 @@ Authors:
>  - Enno Luebbers <enno.luebbers@intel.com>
>  - Xiao Guangrong <guangrong.xiao@linux.intel.com>
>  - Wu Hao <hao.wu@intel.com>
> +- Xu Yilun <yilun.xu@intel.com>
>  
>  The Device Feature List (DFL) FPGA framework (and drivers according to
>  this framework) hides the very details of low layer hardwares and provides
> @@ -530,6 +531,30 @@ Being able to specify more than one DFL per BAR has been considered, but it
>  was determined the use case did not provide value.  Specifying a single DFL
>  per BAR simplifies the implementation and allows for extra error checking.
>  
> +
> +Userspace driver support for DFL devices
> +========================================
> +The purpose of an FPGA is to be reprogrammed with newly developed hardware
> +components. New hardware can instantiate a new private feature in the DFL, and
> +then get a DFL device in their system. In some cases users may need a userspace

   then present a DFL device in the system.

> +driver for the DFL device:
> +
> +* Users may need to run some diagnostic test for their hardwares.

                                                          hardware.

> +* Users may prototype the kernel driver in user space.
> +* Some hardware is designed for specific purposes and does not fit into one of
> +  the standard kernel subsystems.
> +
> +This requires direct access to MMIO space and interrupt handling from
> +userspace. The dfl-uio-pdev module exposes the UIO device interfaces for this
> +purpose. It adds the uio_pdrv_genirq platform device with the resources of
> +the DFL feature, and lets the generic UIO platform device driver provide UIO
> +support to userspace.
> +
> +FPGA_DFL_UIO_PDEV should be selected to enable the dfl-uio-pdev module driver.
> +To support a new DFL feature been directly accessed via UIO, its feature id

   To support a new DFL feature via UIO direct access, its feature id

> +should be added to the driver's id_table.
> +
> +
>  Open discussion
>  ===============
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
> 

HTH.
-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
