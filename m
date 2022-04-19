Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9065076D5
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 19:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354387AbiDSRzR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Apr 2022 13:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354570AbiDSRzK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Apr 2022 13:55:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3FD14000;
        Tue, 19 Apr 2022 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650390746; x=1681926746;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=91tvtGEX/zzxIKkabBBW1fLD4fdIYKpdH7IMCAC8IaA=;
  b=R9PPUbOyojW/x6w/W58lHCeCqr1iGynlfVXLDoQhsvahXDAejYCAzzZF
   qUYYIAzbQNG1fdANzNR8PZEru74SA8BwltJ/47q7WwbOwxpiOP6b2kURp
   5VwO4SwFXhoAl+hNaO/QIJcPEw+aFXNlBPgoFdV2REZd1WHelWaYDSkKq
   jqylicFhsFcg60uKIWu3eZaibS6qcjbwTNl3rX2Jw3eZFonYBZFIz2f11
   Dco8DInRZdNVHylcqla1tklzUQIpEX8wFuxY+XusGyttiTDo7INJUVYzw
   VCt4fev25ocvOt6JMOxl1ZBi3332pLtNWOFs0e1SpS+/UQa16JWcCyQ79
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="326731293"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="326731293"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:52:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554831107"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:52:25 -0700
Date:   Tue, 19 Apr 2022 10:52:05 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>
cc:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] uio: dfl: add HSSI feature id
In-Reply-To: <BN9PR11MB548330FAA7EF6B9DAC2F0E76E3F29@BN9PR11MB5483.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2204191048300.5866@rhweight-WRK1>
References: <20220412062353.53984-1-tianfei.zhang@intel.com> <DM6PR11MB38190E6EEF6DE3EB900290C585F39@DM6PR11MB3819.namprd11.prod.outlook.com> <BN9PR11MB548330FAA7EF6B9DAC2F0E76E3F29@BN9PR11MB5483.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 19 Apr 2022, Zhang, Tianfei wrote:

>
>
>>> -----Original Message-----
>>> From: Zhang, Tianfei <tianfei.zhang@intel.com>
>>> Sent: Tuesday, April 12, 2022 2:24 PM
>>> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
>>> Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
>>> gregkh@linuxfoundation.org
>>> Cc: linux-kernel@vger.kernel.org; Matthew Gerlach
>>> <matthew.gerlach@linux.intel.com>; Zhang, Tianfei
>>> <tianfei.zhang@intel.com>
>>> Subject: [PATCH v2] uio: dfl: add HSSI feature id
>>>
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> Add the feature id of the OFS HSSI (High Speed Serial Interface)
>>
>> We still don't see any description on what OFS is here, or will OFS be added to
>> title as well? we don't expect another submission with the same title but for XXX
>> HSSI again.
>
> This name of HSSI module in dfl feature id table is : OFS HSSI subsystem.
>
> How about this tile:
> uio: dfl: add OFS HSSI device id
>
> Add OFS HSSI (Open FPGA Stack High Speed Serial Interface) device ID in uio_dfl driver for Intel PAC N6000 Card.

Hi Tianfei,

In the Platform Designer tool, this IP block is referred to as the HSSI 
Subsystem.  I think we should use the same name here.  Additionally, this 
subsystem is already in use in multiple cards; so I suggest dropping
any reference to a particular card.

Matthew

>
>>
>>> subsystem to table of ids supported by the uio_dfl driver. HSSI
>>> subsystem consists of harden/soft Ethernet MAC to support various
>>> ethernet usages and PCS/FEC/PMA direct modes for non-ethernet usages.
>>>
>>> We leverage the uio_dfl driver to access the HSSI subsystem on user
>>> space, because the HSSI subsystem was designed for specific purposes
>>> and does not fit into the standard MAC and net kernel subsystems.
>>>
>>> The Feature ID table of DFL can be found:
>>> https://github.com/OPAE/dfl-feature-id
>>
>> Why you put it here? even this link there is no more descriptions to understand
>> what it is. Or can be removed here.
>
> Yes, I agree, I will remove it.
>>
>>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>> ---
>>> v2: add HSSI introduction and the git repo of Feature ID table.
>>> ---
>>>  drivers/uio/uio_dfl.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c index
>>> 89c0fc7b0cbc..660e1d0bf6b9 100644
>>> --- a/drivers/uio/uio_dfl.c
>>> +++ b/drivers/uio/uio_dfl.c
>>> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>>> }
>>>
>>>  #define FME_FEATURE_ID_ETH_GROUP	0x10
>>> +#define FME_FEATURE_ID_OFS_HSSI		0x15
>>>
>>>  static const struct dfl_device_id uio_dfl_ids[] = {
>>>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
>>> +	{ FME_ID, FME_FEATURE_ID_OFS_HSSI },
>>>  	{ }
>>>  };
>>>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
>>> --
>>> 2.26.2
>
>
