Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9433BE647
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Jul 2021 12:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhGGKUH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fpga@lfdr.de>); Wed, 7 Jul 2021 06:20:07 -0400
Received: from smtp.asem.it ([151.1.184.197]:60537 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhGGKUG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Jul 2021 06:20:06 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2021 06:20:06 EDT
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 8.0.0)
        with ESMTP id b7aba910704e45d39b5ac6cd4a01eb53.MSG
        for <linux-fpga@vger.kernel.org>; Wed, 07 Jul 2021 12:12:22 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 7 Jul
 2021 12:12:20 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.2176.009; Wed, 7 Jul 2021 12:12:20 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Paolo Pisati <p.pisati@gmail.com>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: [QUESTION] fpga: machxo2-spi: adapting for machxo3
Thread-Topic: [QUESTION] fpga: machxo2-spi: adapting for machxo3
Thread-Index: AddzF9FvUZrhi+XKQoeML1G//1E0Iw==
Date:   Wed, 7 Jul 2021 10:12:20 +0000
Message-ID: <0df785ad369d49e2b02690388d162792@asem.it>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F16.60E57E05.0024,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi all,

I need to download the fw into a Lattice MachXO3,
using the SPI slave bus, and I have some questions
regarding the existing machxo2-spi driver:

- has anyone tried to download the fw into a MachXO3?
- are there any usage examples for the existing machxo2-spi,
  for example with the fw file name, the user space procedure, etc?

Thanks for your help!

Best regards,

Flavio
