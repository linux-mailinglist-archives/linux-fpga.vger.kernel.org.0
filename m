Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6C243786
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Aug 2020 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMJUs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fpga@lfdr.de>); Thu, 13 Aug 2020 05:20:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:32223 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgHMJUr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 13 Aug 2020 05:20:47 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-156-hgKTbYm5MtyJduu9P-gWoA-1; Thu, 13 Aug 2020 10:20:44 +0100
X-MC-Unique: hgKTbYm5MtyJduu9P-gWoA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 13 Aug 2020 10:20:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 13 Aug 2020 10:20:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Xu Yilun' <yilun.xu@intel.com>
CC:     'Moritz Fischer' <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH v4 1/4] fpga: dfl: change data type of feature id to u16
Thread-Topic: [PATCH v4 1/4] fpga: dfl: change data type of feature id to u16
Thread-Index: AQHWcFyE8iGJWCR9sU2N3RtiiWBxsak0KslwgAFy2oCAABdfEP//+uqAgAAS+MA=
Date:   Thu, 13 Aug 2020 09:20:43 +0000
Message-ID: <20ab5d871b154423a4dcefef1ddd64e2@AcuMS.aculab.com>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-2-git-send-email-yilun.xu@intel.com>
 <20200812035604.GA2544@epycbox.lan>
 <3810fb75b42e45928a39a97449a01520@AcuMS.aculab.com>
 <20200813075843.GB7383@yilunxu-OptiPlex-7050>
 <54216e492cec4f84bc43dee176130e89@AcuMS.aculab.com>
 <20200813090409.GA1080@yilunxu-OptiPlex-7050>
In-Reply-To: <20200813090409.GA1080@yilunxu-OptiPlex-7050>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>
> Sent: 13 August 2020 10:04
> 
> On Thu, Aug 13, 2020 at 08:28:05AM +0000, David Laight wrote:
> > From: Xu Yilun
> > > Sent: 13 August 2020 08:59
> > > On Wed, Aug 12, 2020 at 08:52:39AM +0000, David Laight wrote:
> > > > From: Moritz Fischer
> > > > > Sent: 12 August 2020 04:56
> > > > >
> > > > > On Mon, Aug 10, 2020 at 10:41:10AM +0800, Xu Yilun wrote:
> > > > > > The feature id is stored in a 12 bit field in DFH. So a u16 variable is
> > > > > > enough for feature id.
> > > > > >
> > > > > > This patch changes all feature id related places to fit u16.
> > > >
> > > > How much bigger does it make the kernel?
> > >
> > > The patch changes the definition of feature id from u64 to u16, and will
> > > make the kernel slightly smaller.
> >
> > Unlikely.
> > Most of the structures will gain a 'pad' field.
> > Using u16 for function parameters and results almost certainly
> > requires instructions to mask the value.
> > Any arithmetic on u16 will require masking instructions on
> > (probably) all architectures except x86.
> >
> > Using 'unsigned int' is probably best.
> >
> > u16 is never a good idea unless you are defining enough
> > of them in a structure (eg as an array) to reduce the
> > structure size below some threshold.
> > (Or are matching some hardware layout.)
> 
> I got it. Thanks for your detailed explanation. I think we may change them to
> u32. Is it the same case for u8? Think we may also change the dfl_device_id.type.

Loosely 'yes' but it isn't worth the churn of 'random' changes.
And they aren't often passed to/from functions - which I'm 98% sure
requires masking.

I commented because the compiler was going to add pad fields after
your u16 values - so you'd get do space saving and probably more code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

