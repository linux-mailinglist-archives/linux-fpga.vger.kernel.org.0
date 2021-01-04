Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6559B2E9BE0
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Jan 2021 18:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbhADRUJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 4 Jan 2021 12:20:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:15532 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbhADRUI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 4 Jan 2021 12:20:08 -0500
IronPort-SDR: QJnv9YlHPQCxa7QJjv4ACP5cRrzYJ+kXX0pj3j/vMJVPt7vWsaGMJt1PCq4yAShH0++Z0zk4gr
 1tG7pI5UZUOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="174404779"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="174404779"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 09:19:28 -0800
IronPort-SDR: y/A9Sk543anZLT1cUUWEcLx1DezZg5ViK0aQ4HXtuGxmuGwmUo2vm6VLVPW63KQfbNrOj2eV/n
 aUlvmklYO0Kw==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="462012498"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.151.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 09:19:27 -0800
Subject: Re: [PATCH v5 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <1609557182-20787-3-git-send-email-yilun.xu@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <0f5c3f7c-f367-086f-cd43-d8b23f9a833e@intel.com>
Date:   Mon, 4 Jan 2021 09:19:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1609557182-20787-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 1/1/21 7:13 PM, Xu Yilun wrote:
> This patch adds description for UIO support for dfl devices on DFL
> bus.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: no doc in v1, add it for v2.
> v3: some documentation fixes.
> v4: documentation change since the driver matching is changed.
> v5: no change.
> ---
>  Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 0404fe6..b8497f3 100644
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
> @@ -502,6 +503,29 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
>  
> +UIO support for DFL devices
> +===========================
> +The purpose of an FPGA is to be reprogrammed with newly developed hardware
> +components. New hardware can instantiate a new private feature in the DFL, and
> +then get a DFL device in their system. In some cases users may need a userspace
> +driver for the DFL device:
> +
> +* Users may need to run some diagnostic test for their hardwares.
> +* Users may prototype the kernel driver in user space.
> +* Some hardware is designed for specific purposes and does not fit into one of
> +  the standard kernel subsystems.
> +
> +This requires the direct access to the MMIO space and interrupt handling in
This may be better stated as:

"This requires direct access to MMIO space and interrupt handling from userspace."

- Russ

> +userspace. The dfl-uio-pdev module exposes the UIO device interfaces for this
> +purpose. It adds the uio_pdrv_genirq platform device with the resources of
> +the DFL feature, and lets the generic UIO platform device driver provide UIO
> +support to userspace.
> +
> +FPGA_DFL_UIO_PDEV should be selected to enable the dfl-uio-pdev module driver.
> +To support a new DFL feature been directly accessed via UIO, its feature id
> +should be added to the driver's id_table.
> +
> +
>  Open discussion
>  ===============
>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration

