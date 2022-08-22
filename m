Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1AE59C99F
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Aug 2022 22:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiHVUGh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Aug 2022 16:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiHVUGc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 22 Aug 2022 16:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B05D4056E
        for <linux-fpga@vger.kernel.org>; Mon, 22 Aug 2022 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661198789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jmgCBkQ7H4mvuJoeFGrqFiEKOajhFm7LOtreoBCEa4=;
        b=EuMaBaV2BMaKSa5LzCohh3H+I89BGJlZNzFpc8u90r1VIenrStuEdbx6DokPKes9sPKuW0
        7z/tfNuPK6x4McM0mYL+MXF4AalPvrHq8UoSpJ/scr7AXzlaaoKsGMXBsPaCDh3PGrODWO
        Zy7DDjlunoHWoe9R9mnVd3XipvSvfbg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-OVaTtEhLP3qwljaiishzTg-1; Mon, 22 Aug 2022 16:06:26 -0400
X-MC-Unique: OVaTtEhLP3qwljaiishzTg-1
Received: by mail-qv1-f70.google.com with SMTP id db3-20020a056214170300b00496c0aabfc9so5254911qvb.16
        for <linux-fpga@vger.kernel.org>; Mon, 22 Aug 2022 13:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=+jmgCBkQ7H4mvuJoeFGrqFiEKOajhFm7LOtreoBCEa4=;
        b=TDAjWCFjTir4FcyyWb371DRgc2TAr8zYlkBFJmbb4DvE8bid+JkI+Noj9IwcaOxHzE
         gcYnkUO8rfltKz3nu4i8pgRz60YaX+2bRwOjdo/vSTHkqFIQEi9ohZFdCVAZaemFKU//
         jgarJdMStOvfy5T5Z2zUCT5Cs07hcpFMqWYv6HcBu55axVN1bGkPGK6Mb6VZFAoot9B8
         44ZuQMtyhWVGNE9uhRrGlO9qaa9zIKZGQdUzcISbbGmhRXFF0v6EvmXasBbXKGhVzsMT
         VG/imU4U2RKFM3qFZd0sVFBJnKAMQtULMHL6UT5d1dZSg7qyok++/SZdGHp+d//gz3U1
         ot+Q==
X-Gm-Message-State: ACgBeo262s1jlCNsoebllrV07rUmBQ/SoBX4z9UXwLHqdMRV1CxTjLjp
        qVTeOz+1NdPoIgRQLN1xAg6YgsIVzXnQU9MQD74HkVSw0eybg/vdK5Z/M8anfFdejKhKoy7PCSs
        Ddj8b2HcpD5TK/5fJkP0UXw==
X-Received: by 2002:a05:620a:4409:b0:6bb:beeb:215e with SMTP id v9-20020a05620a440900b006bbbeeb215emr13297345qkp.414.1661198786193;
        Mon, 22 Aug 2022 13:06:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QEycZg3xmKfdJ8HweslExNiA+sIlyC1ICPdFkYeTpsYGaCLTqZB+YeldYWWTtX8Y4jos52w==
X-Received: by 2002:a05:620a:4409:b0:6bb:beeb:215e with SMTP id v9-20020a05620a440900b006bbbeeb215emr13297318qkp.414.1661198785958;
        Mon, 22 Aug 2022 13:06:25 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t24-20020a37ea18000000b006b9526cfe6bsm11524267qkj.80.2022.08.22.13.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:06:25 -0700 (PDT)
Subject: Re: [PATCH v1] uio: dfl: add IOPLL user-clock feature id
To:     Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     Peter Colberg <peter.colberg@intel.com>, Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com
References: <20220817213746.4986-1-peter.colberg@intel.com>
 <Yv29ev8OKyEYcaf/@yilunxu-OptiPlex-7050>
 <acdf9c04-0816-5995-da90-c53153ffac59@intel.com>
 <YwMKzC6HwjYqDxIs@yilunxu-OptiPlex-7050>
 <2d608273-e37d-cb2c-45da-3213aba55f8e@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fee440f4-fd50-68c8-b65f-a900067e91d5@redhat.com>
Date:   Mon, 22 Aug 2022 13:06:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2d608273-e37d-cb2c-45da-3213aba55f8e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 8/22/22 10:38 AM, Russ Weight wrote:
>
> On 8/21/22 21:49, Xu Yilun wrote:
>> On 2022-08-18 at 17:38:35 -0600, Russ Weight wrote: >> >> >> On 8/17/2=
2 21:18, Xu Yilun wrote: >>> On 2022-08-17 at 17:37:46 -0400, Peter Colbe=
rg wrote: >>>> Add a Device Feature List (DFL) feature id for the >>>> co=
nfigurable IOPLL user clock source, which can be used to >>>> configure t=
he clock speeds that are used for RTL logic that is >>>> programmed into =
the Partial Reconfiguration (PR) region of an >>>> FPGA. >>> Why not use =
linux clock framework for this IOPLL? And let the PR >>> driver set it to=
geter with the RTL logic reporgramming? >> >> Hi Yilun, >> >> We previous=
ly explored the possibility of plugging into the linux >> clock framework=
=2E For this device, setting a desired frequency is >> heavily dependent =
on a table of values that must be programmed in >> order to achieve the d=
esired clock speeds. >> >> Here is an example table, indexed by frequency=
=2E The first element >> in each entry is the frequency in kHz: >> >> htt=
ps://github.com/OPAE/opae-sdk/blob/master/libraries/plugins/xfpga/usrclk/=
fpga_user_clk_freq.h >> >>
>>>>>>>>>>> We previously experimented with a kernel-space driver. The
>>> implementation exported a sysfs node into which the table values >> f=
or the desired frequency would be written in order to set the >> desired =
frequency. The function of the driver was to execute the >> logic require=
d to program the device. We did not think this >> implementation should b=
e up-streamed. >> >> It isn't practical to upstream the frequency tables =
as they are >> subject to change for future devices. For example, if the =
>> reference frequency changed in a future device, a whole new table >> o=
f values would have to be added for the new device. In a recent >> transi=
tion to a new device, the range of frequencies was increased >> which req=
uired an extension to an existing table. > > Making a table for the input=
s & outputs is always a easier way to > get things done, but the trade of=
f is, as you said, extension to the > table every time for new outputs. >=
 > So do we really need all parameters to be in a table, or these are > a=
ctually the outcome of some calculation? Is it possible just > Implementi=
ng the calculation.
> For each desired frequency, the table values are produced by calling
> the quartus tool, the same tool that generates the IOPLL RTL logic.
> The quartus tool allows the RTL designer to select different options
> which can affect the table values. For example, the current IOPLL
> used in OFS has two frequency outputs and the desired relationship
> between the two frequencies is 1x/2x until the 2x frequency reaches
> a threshold (about 800MHz) and then the relationship is modified.
>
> To convert this process into an algorithm would require reverse
> engineering the quartus algorithm for the set of variables and
> clock relationships in a specific implementation. The resulting
> algorithm would have a very narrow application; we would have to
> upstream additional algorithms for future, modified implementations.
> Also, customers have the ability to modify the IOPLL implementation
> if they choose. A table driven driver enables customers to easily
> adapt the driver to their implementation.
>
> We think a userspace table-driven driver is the best approach for
> supporting the user clock.
>
> - Russ

Agreeing with Russ, let's move this out to userspace.

Tom

>
>>>> If I remember correctly, linux clk framework enables a generic clk >=
 caculation mechanism. It encourages people to model the internal > refcl=
k, plls (and deviders?) separately and construct the clk tree. > Then the=
 specified calculation could be simpler for each clk driver. > > I'm not =
sure the clk framework fits all your need, but please > investigate it fi=
rstly. > >> >> A previous implementation of the user clock was also imple=
mented >> in user-space. The kernel driver exported each of the registers=
, >> but all of the logic was implemented in user-space. The kernel >> po=
rtion can be viewed here: >> >> https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git/tree/drivers/fpga/dfl-afu-main.c#n380 >> >> >> =
>> >> >> >> This is our reasoning in choosing to implement this driver in=

>>> user-space. Would you consider a uio based user-space driver to be >>=
 acceptable for in this case? > > As usual, we firstly make clear why exi=
sting framework cannot fit > the case and should be implemented in usersp=
ace, then everything > would be OK. > > Thanks, Yilun > >> >> - Russ >> >=
> >>> >>> Thanks, Yilun >>> >>>> The DFL feature id table can be found at=
: >>>> https://github.com/OPAE/dfl-feature-id >>>> >>>> Signed-off-by: Pe=
ter Colberg <peter.colberg@intel.com> --- >>>> drivers/uio/uio_dfl.c | 2 =
++ 1 file changed, 2 insertions(+) >>>> >>>> diff --git a/drivers/uio/uio=
_dfl.c b/drivers/uio/uio_dfl.c >>>> index 8f39cc8bb034..69e93f3e7faf 1006=
44 --- >>>> a/drivers/uio/uio_dfl.c +++ b/drivers/uio/uio_dfl.c @@ -46,10=
 >>>> +46,12 @@ static int uio_dfl_probe(struct dfl_device *ddev) >>>> >>=
>> #define FME_FEATURE_ID_ETH_GROUP 0x10 #define >>>> FME_FEATURE_ID_HSSI=
_SUBSYS 0x15 +#define >>>> PORT_FEATURE_ID_IOPLL_USRCLK 0x14 >>>> >>>> st=
atic const struct dfl_device_id uio_dfl_ids[] =3D { { FME_ID, >>>> FME_FE=
ATURE_ID_ETH_GROUP }, { FME_ID, >>>>
> FME_FEATURE_ID_HSSI_SUBSYS }, + { PORT_ID, >>>> PORT_FEATURE_ID_IOPLL_U=
SRCLK }, { } }; MODULE_DEVICE_TABLE(dfl, >>>> uio_dfl_ids); -- 2.28.0 >>>=
> >>
>

