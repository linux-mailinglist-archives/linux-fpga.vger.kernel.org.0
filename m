Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0663F59CDEE
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Aug 2022 03:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbiHWBaq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Aug 2022 21:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiHWBao (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 22 Aug 2022 21:30:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A215A3CD;
        Mon, 22 Aug 2022 18:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661218243; x=1692754243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vt4AFWHgXbuUrc0GhtGvhk0R/mwczF5Lvtj9mAukw/A=;
  b=eK1hCIjD35FqZ77Cmj1VMaqDI454gCTk8oX00NdTIQJh8sUag2pmycMJ
   YJXHB55kVGqyCxLGWChRt9e+fOQq3KpLhvTNpWSlXou3e/Q9eGWREwjRj
   flJHwLWjWlGOqVfQJba37ECj/NPxYb0kGXG2/VOe2CO5J4d3fsr7NYRgI
   cLjHcz1O/aC5Myo1f0g4VQUlWKsssdHUY0PYpJIJZkl/MmpCsFe6k1wJV
   yG7ylasqNbGRiwBsaYedwyr0dJgE04KNIGYyhwZS9ysqk7C4txeUtuMcc
   lHv22S46x6heXr2Uoj9uuA5cBrqQ+7LQcK39XYzvbnN6KZN1r2WHjo9bs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="319603046"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="319603046"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 18:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="585767679"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 22 Aug 2022 18:30:21 -0700
Date:   Tue, 23 Aug 2022 09:21:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Peter Colberg <peter.colberg@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com
Subject: Re: [PATCH v1] uio: dfl: add IOPLL user-clock feature id
Message-ID: <YwQrhaAvES/wqS9i@yilunxu-OptiPlex-7050>
References: <20220817213746.4986-1-peter.colberg@intel.com>
 <Yv29ev8OKyEYcaf/@yilunxu-OptiPlex-7050>
 <acdf9c04-0816-5995-da90-c53153ffac59@intel.com>
 <YwMKzC6HwjYqDxIs@yilunxu-OptiPlex-7050>
 <2d608273-e37d-cb2c-45da-3213aba55f8e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2d608273-e37d-cb2c-45da-3213aba55f8e@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-22 at 10:38:51 -0700, Russ Weight wrote:
>=20
>=20
> On 8/21/22 21:49, Xu Yilun wrote:
> > On 2022-08-18 at 17:38:35 -0600, Russ Weight wrote: >> >> >> On 8/17/22=
 21:18, Xu Yilun wrote: >>> On 2022-08-17 at 17:37:46 -0400, Peter Colberg =
wrote: >>>> Add a Device Feature List (DFL) feature id for the >>>> configu=
rable IOPLL user clock source, which can be used to >>>> configure the cloc=
k speeds that are used for RTL logic that is >>>> programmed into the Parti=
al Reconfiguration (PR) region of an >>>> FPGA. >>> Why not use linux clock=
 framework for this IOPLL? And let the PR >>> driver set it togeter with th=
e RTL logic reporgramming? >> >> Hi Yilun, >> >> We previously explored the=
 possibility of plugging into the linux >> clock framework. For this device=
, setting a desired frequency is >> heavily dependent on a table of values =
that must be programmed in >> order to achieve the desired clock speeds. >>=
 >> Here is an example table, indexed by frequency. The first element >> in=
 each entry is the frequency in kHz: >> >> https://github.com/OPAE/opae-sdk=
/blob/master/libraries/plugins/xfpga/usrclk/fpga_user_clk_freq.h >> >>
> >> >> >> >> >> We previously experimented with a kernel-space driver. The
> >> implementation exported a sysfs node into which the table values >> fo=
r the desired frequency would be written in order to set the >> desired fre=
quency. The function of the driver was to execute the >> logic required to =
program the device. We did not think this >> implementation should be up-st=
reamed. >> >> It isn't practical to upstream the frequency tables as they a=
re >> subject to change for future devices. For example, if the >> referenc=
e frequency changed in a future device, a whole new table >> of values woul=
d have to be added for the new device. In a recent >> transition to a new d=
evice, the range of frequencies was increased >> which required an extensio=
n to an existing table. > > Making a table for the inputs & outputs is alwa=
ys a easier way to > get things done, but the trade off is, as you said, ex=
tension to the > table every time for new outputs. > > So do we really need=
 all parameters to be in a table, or these are > actually the outcome of so=
me calculation? Is it possible just > Implementing the calculation.
> For each desired frequency, the table values are produced by calling
> the quartus tool, the same tool that generates the IOPLL RTL logic.

OK, this is an important reason.

> The quartus tool allows the RTL designer to select different options
> which can affect the table values. For example, the current IOPLL
> used in OFS has two frequency outputs and the desired relationship
> between the two frequencies is 1x/2x until the 2x frequency reaches
> a threshold (about 800MHz) and then the relationship is modified.
>=20
> To convert this process into an algorithm would require reverse
> engineering the quartus algorithm for the set of variables and
> clock relationships in a specific implementation. The resulting
> algorithm would have a very narrow application; we would have to

This makes sense to me.

> upstream additional algorithms for future, modified implementations.
> Also, customers have the ability to modify the IOPLL implementation
> if they choose. A table driven driver enables customers to easily

That also makes sense to me.

> adapt the driver to their implementation.

So could you please add some brief description in commit message? The
code is good to me.

Thanks,
Yioun

>=20
> We think a userspace table-driven driver is the best approach for
> supporting the user clock.
>=20
> - Russ
>=20
> > > > If I remember correctly, linux clk framework enables a generic clk =
> caculation mechanism. It encourages people to model the internal > refclk=
, plls (and deviders?) separately and construct the clk tree. > Then the sp=
ecified calculation could be simpler for each clk driver. > > I'm not sure =
the clk framework fits all your need, but please > investigate it firstly. =
> >> >> A previous implementation of the user clock was also implemented >>=
 in user-space. The kernel driver exported each of the registers, >> but al=
l of the logic was implemented in user-space. The kernel >> portion can be =
viewed here: >> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds=
/linux.git/tree/drivers/fpga/dfl-afu-main.c#n380 >> >> >> >> >> >> >> This =
is our reasoning in choosing to implement this driver in
> >> user-space. Would you consider a uio based user-space driver to be >> =
acceptable for in this case? > > As usual, we firstly make clear why existi=
ng framework cannot fit > the case and should be implemented in userspace, =
then everything > would be OK. > > Thanks, Yilun > >> >> - Russ >> >> >>> >=
>> Thanks, Yilun >>> >>>> The DFL feature id table can be found at: >>>> ht=
tps://github.com/OPAE/dfl-feature-id >>>> >>>> Signed-off-by: Peter Colberg=
 <peter.colberg@intel.com> --- >>>> drivers/uio/uio_dfl.c | 2 ++ 1 file cha=
nged, 2 insertions(+) >>>> >>>> diff --git a/drivers/uio/uio_dfl.c b/driver=
s/uio/uio_dfl.c >>>> index 8f39cc8bb034..69e93f3e7faf 100644 --- >>>> a/dri=
vers/uio/uio_dfl.c +++ b/drivers/uio/uio_dfl.c @@ -46,10 >>>> +46,12 @@ sta=
tic int uio_dfl_probe(struct dfl_device *ddev) >>>> >>>> #define FME_FEATUR=
E_ID_ETH_GROUP 0x10 #define >>>> FME_FEATURE_ID_HSSI_SUBSYS 0x15 +#define >=
>>> PORT_FEATURE_ID_IOPLL_USRCLK 0x14 >>>> >>>> static const struct dfl_dev=
ice_id uio_dfl_ids[] =3D { { FME_ID, >>>> FME_FEATURE_ID_ETH_GROUP }, { FME=
_ID, >>>>
> FME_FEATURE_ID_HSSI_SUBSYS }, + { PORT_ID, >>>> PORT_FEATURE_ID_IOPLL_USR=
CLK }, { } }; MODULE_DEVICE_TABLE(dfl, >>>> uio_dfl_ids); -- 2.28.0 >>>> >>
>=20
