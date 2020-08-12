Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB52426F7
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Aug 2020 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHLIwo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fpga@lfdr.de>); Wed, 12 Aug 2020 04:52:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41501 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbgHLIwo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 12 Aug 2020 04:52:44 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-131-PGibDhx1Ola_bVuldcp2IA-1; Wed, 12 Aug 2020 09:52:40 +0100
X-MC-Unique: PGibDhx1Ola_bVuldcp2IA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 12 Aug 2020 09:52:39 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 12 Aug 2020 09:52:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Moritz Fischer' <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH v4 1/4] fpga: dfl: change data type of feature id to u16
Thread-Topic: [PATCH v4 1/4] fpga: dfl: change data type of feature id to u16
Thread-Index: AQHWcFyE8iGJWCR9sU2N3RtiiWBxsak0Kslw
Date:   Wed, 12 Aug 2020 08:52:39 +0000
Message-ID: <3810fb75b42e45928a39a97449a01520@AcuMS.aculab.com>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-2-git-send-email-yilun.xu@intel.com>
 <20200812035604.GA2544@epycbox.lan>
In-Reply-To: <20200812035604.GA2544@epycbox.lan>
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

From: Moritz Fischer
> Sent: 12 August 2020 04:56
> 
> On Mon, Aug 10, 2020 at 10:41:10AM +0800, Xu Yilun wrote:
> > The feature id is stored in a 12 bit field in DFH. So a u16 variable is
> > enough for feature id.
> >
> > This patch changes all feature id related places to fit u16.

How much bigger does it make the kernel?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

