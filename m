Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56E15B4FDC
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIKQGg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 12:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIKQGf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 12:06:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16A82497E;
        Sun, 11 Sep 2022 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662912395; x=1694448395;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+N93ngh3HO0DUnK769NJCjP/Lgd0Phq1/ZPbwKIbUvs=;
  b=mx2bYIkM5SqVFjiUNp7WI9hj3pCAZW6/hQRH96LzhACSuD4yzfpKnjN+
   0ZV8uPiB95V4y5hk/qAXeq/dTVua/nsQa9I2qt476voMJ6rWhAmBrODDF
   ZPxGxAmMIdsoppEl3JcXDZx94bAAD7BdNH5zrj8OsRYCKBokfXfaUEXuh
   Jg3FmmzboPiqxZyD/HheELm3GDycUEousIK4IKufP+UolDTzNcXnjT1aQ
   Zlwev8Z18Xkd0U6ViMCObhKbHPSPY/QsF6aDiPxVQCO5GJZBRUthsJP21
   Gipb5Uemly9yfWk6kRNSbDZCMd+gW7UkE9qUXzDwiqNgmnpTHFoJ8uAlc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299072976"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="299072976"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 09:06:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="684182310"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 09:06:32 -0700
Date:   Sun, 11 Sep 2022 09:06:52 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Xu Yilun <yilun.xu@intel.com>
cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 1/5] Documentation: fpga: dfl: Add documentation for
 DFHv1
In-Reply-To: <Yx2w+yl9SFFx0Qtx@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2209110905520.142336@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-2-matthew.gerlach@linux.intel.com> <Yx2w+yl9SFFx0Qtx@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Sun, 11 Sep 2022, Xu Yilun wrote:

> On 2022-09-06 at 12:04:22 -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add documentation describing the extentions provided by Version
>> 1 of the Device Feature Header (DFHv1).
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>> index 15b670926084..31699b89781e 100644
>> --- a/Documentation/fpga/dfl.rst
>> +++ b/Documentation/fpga/dfl.rst
>> @@ -561,6 +561,30 @@ new DFL feature via UIO direct access, its feature id should be added to the
>>  driver's id_table.
>>
>>
>> +Extending the Device Feature Header - DFHv1
>> +===========================================
>> +The current 8 bytes of the Device Feature Header, hereafter referred to as
>> +to DFHv0, provide very little opportunity for the hardware to describe itself
>> +to software. Version 1 of the Device Feature Header (DFHv1) is being introduced
>> +to provide increased flexibility and extensibility to hardware designs using
>> +Device Feature Lists.  The list below describes some of the goals behind the
>> +changes in DFHv1:
>> +
>> +* Provide a standardized mechanism for features to describe
>> +  parameters/capabilities to software.
>> +* Standardize the use of a GUID for all DFHv1 types.
>> +* Decouple the location of the DFH from the register space of the feature itself.
>> +
>> +Modeled after PCI Capabilities, DFHv1 Parameters provide a mechanism to associate
>> +a list of parameter values to a particular feature.
>> +
>> +With DFHv0, not all features types contained a GUID.  DFHv1 makes the GUILD standard
>> +across all types.
>> +
>> +With DFHv0, the register map of a given feature is located immediately following
>> +the DFHv0 in the memory space.  With DFHv1, the location of the feature register
>> +map can be specified as an offset to the DFHv1 or as an absolute address.
>
> Could you make a table or diagram to describe the data structure layout of DFHv1
> extention.
>
> Thanks,
> Yilun

I was hoping that the actual macro definitions would be sufficient, but I 
will look into making a table.

Matthew Gerlach

>
>> +
>>  Open discussion
>>  ===============
>>  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
>> --
>> 2.25.1
>>
>
