Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEA5621BE8
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 19:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKHS2n (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 13:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKHS2m (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 13:28:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B202643;
        Tue,  8 Nov 2022 10:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932121; x=1699468121;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wZVQ8D4GzXjrmMnXjglPuPUT5tajKbNEVDNTUlYv4Jc=;
  b=BtxZhNXHN8pVr2G61K09JDEoA4Jgs6PbJpt17sbt7RiSYlxYjItAKgX4
   C97Sx37aoOVgxRaglIPUgvSzlPpe5OPyhoAQ/SX+LCvFxjXJ21tKnCyih
   N4ZS3lXhtR7UU7PFILpVweUxWLU68mwrjgFd5MTbQoYAwIGA/xiVwpZC+
   lpbojJ2W8H6HfWOq69DUy5DsYXtD0mT2ESSrn7v6MNluY5dsSa67r8kSu
   kqIXJTabisdNNA50mLfLQ/p7PZke9pq4OLlc1mRk1aaxlxI73iS7ioxSV
   mhSECFhGq7CCc2PaukA7rB5ftQsEHIfBdUCAVnGlQ9YIFNsr4qQq6odYA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="337503805"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="337503805"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:28:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="636435661"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="636435661"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:28:41 -0800
Date:   Tue, 8 Nov 2022 10:29:02 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] intel-m10-bmc: Add regmap_indirect_cfg for Intel
 FPGA IPs
In-Reply-To: <20221108144305.45424-10-ilpo.jarvinen@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2211081028180.714603@rhweight-WRK1>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com> <20221108144305.45424-10-ilpo.jarvinen@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1813661084-1667932148=:714603"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1813661084-1667932148=:714603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Tue, 8 Nov 2022, Ilpo Järvinen wrote:

> Create the regmap_indirect_cfg with offsets and commands for Intel FPGA
> IPs indirect register access.

This is a great improvement.

Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> include/linux/mfd/intel-m10-bmc.h | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index ed920f76d3c8..1b907c1a176f 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -15,6 +15,19 @@ enum m10bmc_type {
> 	M10_N5010,
> };
>
> +#define INTEL_M10_REGMAP_INDIRECT_CFG	\
> +	.cmd_offset = 0,	\
> +	.idle_cmd = 0,		\
> +	.read_cmd = BIT(0),	\
> +	.write_cmd = BIT(1),	\
> +	.ack_offset = 0,	\
> +	.ack_mask = BIT(2),	\
> +	.addr_offset = 0x4,	\
> +	.read_offset = 0x8,	\
> +	.write_offset = 0xc,	\
> +	.sleep_us = 1,		\
> +	.timeout_us = 10000
> +
> #define M10BMC_STAGING_SIZE		0x3800000
>
> /* Doorbell register fields */
> -- 
> 2.30.2
>
>
--8323328-1813661084-1667932148=:714603--
