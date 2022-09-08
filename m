Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5675B27A6
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Sep 2022 22:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiIHUVt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Sep 2022 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIHUVs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Sep 2022 16:21:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F992EC74A;
        Thu,  8 Sep 2022 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662668507; x=1694204507;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=a7T/JGLT6ZN2mqHLe4wvsZL3e/wJbh1R0c15TYv0olA=;
  b=Kyn2rGHU+Gr2WOKOPlAZ6r6W40cjNWB2GmN2NCoKaR03AfaXwY0Q4BqU
   W8lIOCgPUhFTHHjArWwDMH+xsfsnoaBz6c1rQqp1NY/deReN+WkOvgmbq
   CyESzPZtYm46HcscqthtkA5crwSqi+lLppgOy0Lsgbts6iw9jU9swmLG1
   QYqpgsBrVO1yBrAA6aHPURYlleL9lWyTkcqbmhM60OsNjVjLPyTw8J/uA
   H9gdd5eM5QArCM6lLJP8IpJfF/pRnxKNE0YZZFldpGQ1sOgLBFeh/YAVA
   gsbMwdgnJx3iQhyJRqIy/eiIiKDZwxUBD2FNI5PAKw7V0Y2IvvXj2pito
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277703539"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="277703539"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:21:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="648182741"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 13:21:45 -0700
Date:   Thu, 8 Sep 2022 13:21:57 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?ISO-8859-15?Q?Niklas_S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 4/5] fpga: dfl: add generic support for MSIX
 interrupts
In-Reply-To: <CAMuHMdWwRXKP51vX9KYjiwdZ9mUhsnLxkrAex+LwKpCw-H7=8A@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2209081318250.61321@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-5-matthew.gerlach@linux.intel.com> <YxeqTdny7Nu7LzZo@smile.fi.intel.com> <alpine.DEB.2.22.394.2209071433320.3336870@rhweight-WRK1> <YxnMLI17XvjN74DW@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2209081031450.61321@rhweight-WRK1> <CAMuHMdWwRXKP51vX9KYjiwdZ9mUhsnLxkrAex+LwKpCw-H7=8A@mail.gmail.com>
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



On Thu, 8 Sep 2022, Geert Uytterhoeven wrote:

> Hi Matthew,
>
> On Thu, Sep 8, 2022 at 7:34 PM <matthew.gerlach@linux.intel.com> wrote:
>> On Thu, 8 Sep 2022, Andy Shevchenko wrote:
>>> On Wed, Sep 07, 2022 at 02:37:32PM -0700, matthew.gerlach@linux.intel.com wrote:
>>>> On Tue, 6 Sep 2022, Andy Shevchenko wrote:
>>>>> On Tue, Sep 06, 2022 at 12:04:25PM -0700, matthew.gerlach@linux.intel.com wrote:
>>>
>>> ...
>>>
>>>>>> +  if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
>>>>>> +      fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
>>>>>> +          v = readq(base);
>>>>>> +          v = FIELD_GET(DFH_VERSION, v);
>>>>>> +
>>>>>> +          if (v == 1) {
>>>>>> +                  v =  readq(base + DFHv1_CSR_SIZE_GRP);
>>>>>
>>>>> I am already lost what v keeps...
>>>>>
>>>>> Perhaps
>>>>>
>>>>>             v = readq(base);
>>>>>             switch (FIELD_GET(DFH_VERSION, v)) {
>>>>>             case 1:
>>>>>                     ...
>>>>>                     break;
>>>>>             }
>>>>
>>>> How about?
>>>>              if (FIELD_GET(DFH_VERSION, readq(base)) == 1) {
>>>>                      ...
>>>>              }
>>>
>>> This one tends to be expanded in the future, so I would keep it switch case.
>>>
>>
>> I'm okay with using the switch statement, but how about the following?
>>
>>                 switch (FIELD_GET(DFH_VERSION, readq(base))) {
>>                  case 1:
>>                         ...
>>                         break;
>>                 }
>
> Would it make sense to print an error if a newer version than 1 is detected?
> BTW, what is the expected value when DFHv1 is not detected? Zero
> or an arbitrary number?
>
> Gr{oetje,eeting}s,
>
>                        Geert
>

Hi Geert,

Currently, DFHs that are not version 1 should be version 0. I will fill in 
the switch statement to do nothing for version 0, and the default case 
will print a warning of an unexpected version.

Thanks for the feedback.

Matthew Gerlach
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                -- Linus Torvalds
>
