Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7B5EABDD
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Sep 2022 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiIZP7o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Sep 2022 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiIZP7T (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Sep 2022 11:59:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF507AE73;
        Mon, 26 Sep 2022 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664203686; x=1695739686;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ApUD8PJZgoHpd3NiZopnRx0+jOuuZwHI0s8b4Xeyra0=;
  b=KvJdfmoAy+VzB8NJ7/3Kcu8gNuwF0SHYrl+nAtyH+2lyb3cAft+KiRjj
   FNV6tf5auzBHg8DLVjBQFJKPVQUDaGWaWyZChTbcS5iiGEbzratrhciuV
   AirYwY7ogt4UuscnIdZBPqGSujqBS9oR6FIyFLj2UqYs+T3cHeuW1ROYL
   RzLCO+YOfMcTqzpd3Yu1aT8KydzBOB/MZBtH1CREth+/Wv17tCezpoPjG
   EVKxi4W8CgfKLq9S9G8EMyeePm+ba1WMJ8li/vESgnYT6BW1ajdZoNXb3
   yv+4noECIgcRRMxlhljuJ5Xn+GAafxR+n3Z2iRVHH2lNk0+VdtGb2u3yN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280771484"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="280771484"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 07:47:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="710144915"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="710144915"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 07:47:56 -0700
Date:   Mon, 26 Sep 2022 07:47:46 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 4/6] fpga: dfl: add generic support for MSIX
 interrupts
In-Reply-To: <a602677-78ac-23a0-1a63-96b325595998@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209260734490.363733@rhweight-WRK1>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com> <20220923121745.129167-5-matthew.gerlach@linux.intel.com> <a602677-78ac-23a0-1a63-96b325595998@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-119000197-1664203695=:363733"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-119000197-1664203695=:363733
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 23 Sep 2022, Ilpo Järvinen wrote:

> On Fri, 23 Sep 2022, matthew.gerlach@linux.intel.com wrote:
>
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Define and use a DFHv1 parameter to add generic support for MSIX
>> interrupts for DFL devices.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v2: fix kernel doc
>>     clarify use of DFH_VERSION field
>> ---
>>  drivers/fpga/dfl.c  | 60 +++++++++++++++++++++++++++++++++++++++++----
>>  include/linux/dfl.h | 14 +++++++++++
>>  2 files changed, 69 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>> index 1132f3c10440..dfd3f563c92d 100644
>> --- a/drivers/fpga/dfl.c
>> +++ b/drivers/fpga/dfl.c
>> @@ -941,23 +941,22 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>>  	void __iomem *base = binfo->ioaddr + ofst;
>>  	unsigned int i, ibase, inr = 0;
>>  	enum dfl_id_type type;
>> -	int virq;
>> +	int virq, off;
>>  	u64 v;
>>
>>  	type = feature_dev_id_type(binfo->feature_dev);
>>
>>  	/*
>>  	 * Ideally DFL framework should only read info from DFL header, but
>> -	 * current version DFL only provides mmio resources information for
>> +	 * current version, DFHv0, only provides mmio resources information for
>>  	 * each feature in DFL Header, no field for interrupt resources.
>>  	 * Interrupt resource information is provided by specific mmio
>>  	 * registers of each private feature which supports interrupt. So in
>>  	 * order to parse and assign irq resources, DFL framework has to look
>>  	 * into specific capability registers of these private features.
>>  	 *
>> -	 * Once future DFL version supports generic interrupt resource
>> -	 * information in common DFL headers, the generic interrupt parsing
>> -	 * code will be added. But in order to be compatible to old version
>> +	 * DFHv1 supports generic interrupt resource information in DFHv1
>> +	 * parameter blocks. But in order to be compatible to old version
>>  	 * DFL, the driver may still fall back to these quirks.
>>  	 */
>>  	if (type == PORT_ID) {
>> @@ -981,6 +980,36 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>>  		}
>>  	}
>>
>> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
>> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
>> +
>> +		v = FIELD_GET(DFH_VERSION, readq(base));
>
> I'd call this variable version (or ver) if you want to store it but it
> would also fit to switch () line so that no extra variable is needed.

I will change the v to dfh_ver to be clearer.  I want to store the 
value because it is used in the default case in the error message.  The 
error message helps to debug broken FPGA images.

>
>> +		switch (v) {
>> +		case 0:
>> +			break;
>> +
>> +		case 1:
>> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);
>
> Extra space.

I will remove extra space.

>
>> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
>> +				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
>> +						     DFHv1_PARAM_ID_MSIX);
>> +				if (off >= 0) {
>
> I'd reverse these 2 conditions and break when there's nothing to do.

I'm not sure what you mean by reversing these conditions because a DFHv1 
may or may not have parameters (the first condition), and a DFHv1 may have
parameters but may not have a MSI-X parameter (the second condition).

>
>> +					ibase = readl(base + DFHv1_PARAM_HDR +
>> +						      off + DFHv1_PARAM_MSIX_STARTV);
>> +					inr = readl(base + DFHv1_PARAM_HDR +
>> +						    off + DFHv1_PARAM_MSIX_NUMV);
>> +					dev_dbg(binfo->dev, "start %d num %d fid 0x%x\n",
>> +						ibase, inr, fid);
>> +				}
>> +			}
>> +			break;
>> +
>> +		default:
>> +			dev_warn(binfo->dev, "unexpected DFH version %lld\n", v);
>> +			break;
>> +		}
>> +	}
>> +
>>  	if (!inr) {
>>  		*irq_base = 0;
>>  		*nr_irqs = 0;
>
> -- 
> i.
>
>
--8323328-119000197-1664203695=:363733--
