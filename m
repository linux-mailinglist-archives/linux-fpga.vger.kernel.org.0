Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2923260B404
	for <lists+linux-fpga@lfdr.de>; Mon, 24 Oct 2022 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiJXRXX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 Oct 2022 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiJXRXD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 24 Oct 2022 13:23:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2930B10D695;
        Mon, 24 Oct 2022 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666627090; x=1698163090;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KF8Fkwnt0swwTeTSQoG35DuMH7urFi84yTD7/k3447s=;
  b=iWcf2MUMOWojkBMgaMng4oDsQaCoa4ey+XKqlKbxAMVfkMf+T64lJbQd
   w/x95mYR5gWyqnZxHASCkARdEz5jIeAEwyqc65fkb+qK++twUZIe3Clgk
   CmPpruVORq6oqDWCHqgt2csSRza/a59A/YFZ9HIs44UZ74fbIWubsj6iQ
   IB1lqQBS1A39oOSo4OCRiumrTE0aKCtusMMq8kA4g7LVNJEfVFArHR0bS
   o2AflkoayInpGluuQetlhYhWpjXhoC/YHOB+cw5sCnFotN58nA9TSl8b6
   QVsQmMdyRwy58+vSon45wK+2Uohol+G0jkQp/9RfTu7TfROZvUXEc+SVg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287840235"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287840235"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:09:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="773850887"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="773850887"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 08:09:17 -0700
Date:   Mon, 24 Oct 2022 08:09:34 -0700 (PDT)
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
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, Lukas Wunner <lukas@wunner.de>,
        marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
In-Reply-To: <97f6047-e364-8ae7-195c-4cf33c4b3ec7@linux.intel.com>
Message-ID: <alpine.DEB.2.22.394.2210240808400.2070724@rhweight-WRK1>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-4-matthew.gerlach@linux.intel.com> <97f6047-e364-8ae7-195c-4cf33c4b3ec7@linux.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2044127639-1666624175=:2070724"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2044127639-1666624175=:2070724
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 21 Oct 2022, Ilpo Järvinen wrote:

> On Thu, 20 Oct 2022, matthew.gerlach@linux.intel.com wrote:
>
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add generic support for MSI-X interrupts for DFL devices.
>>
>> The location of a feature's registers is explicitly
>> described in DFHv1 and can be relative to the base of the DFHv1
>> or an absolute address.  Parse the location and pass the information
>> to DFL driver.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> v4: s/MSIX/MSI_X
>>     move kernel doc to implementation
>>     use structure assignment
>>     fix decode of absolute address
>>     clean up comment in parse_feature_irqs
>>     remove use of csr_res
>>
>> v3: remove unneeded blank line
>>     use clearer variable name
>>     pass finfo into parse_feature_irqs()
>>     refactor code for better indentation
>>     use switch statement for irq parsing
>>     squash in code parsing register location
>>
>> v2: fix kernel doc
>>     clarify use of DFH_VERSION field
>> ---
>
>> +static int dfh_get_psize(void __iomem *dfh_base, resource_size_t max)
>> +{
>> +	int size = 0;
>> +	u64 v, next;
>> +
>> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS,
>> +		       readq(dfh_base + DFHv1_CSR_SIZE_GRP)))
>> +		return 0;
>> +
>> +	while (size + DFHv1_PARAM_HDR < max) {
>> +		v = readq(dfh_base + DFHv1_PARAM_HDR + size);
>> +
>> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
>> +		if (!(next & ~DFHv1_PARAM_HDR_NEXT_MASK))
>
> In general, try to not use inverse logic for defining masks. However here,
> just change DFHv1_PARAM_HDR_NEXT_OFFSET to not include any extra bits
> (no rsvd nor eop) and you no longer need this extra masking.

I agree that defining the fields better and using FIELD_GET would make 
this code cleaner.

>
>> +			return -EINVAL;
>> +
>> +		size += next & ~DFHv1_PARAM_HDR_NEXT_MASK;
>
> ...Then you can drop this anding too.
>
>> +
>> +		if (next & DFHv1_PARAM_HDR_NEXT_EOL)
>
> Your docs say EOP, but here you use EOL.

Thanks for catching the inconsistency.

>
> Change DFHv1_PARAM_HDR_NEXT_EOL such that this is extracted directly from
> v.
>
> -- 
> i.
>
--8323328-2044127639-1666624175=:2070724--
