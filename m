Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8FA606E90
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Oct 2022 05:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJUDzs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Oct 2022 23:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJUDzr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Oct 2022 23:55:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8525410B7B0;
        Thu, 20 Oct 2022 20:55:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f140so1466491pfa.1;
        Thu, 20 Oct 2022 20:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydW8idriKNC2qWZ2NNP9E3hFkvUES86aIgZ4PhkNNUM=;
        b=ZVRli+EnuCBFlDVMIp+vggd7bUU/grcJ5d0hzX+7ywWFNaNEgvBERDCmX7zoYAgoqM
         969TML8Zg0UNXlfdQFyV7WHRWWRTDAPEyVYXGDT4+5KphQ+vg4PFf00jGIfBAUA20SuE
         ynW6lbel7JgscEDCQv7IXpnilVXgRl6loHONE8rYuwGHK3Y2nqhhtBLC609SEY34Yxn/
         sEgQ0ht4FMNigYhDtQk0f8jcBuKcns9GLV6M1aawTEqtBmWuzKyfBM5/MY+ltCj8Uq93
         lqvpVyd4KXLiNgvkn2lCzc2ol+vv6uWA0QKgpSaVWHptBTKf0WqjpM2Q6ymHEcf7x+Ci
         62qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydW8idriKNC2qWZ2NNP9E3hFkvUES86aIgZ4PhkNNUM=;
        b=Hj/p93B4shCav3Ok7MreJyD6JqwI9qb3N+K/LA+Lsz8kn6ywjigOOgQUgUxtrS2mmh
         fQ9aip7kdKmQAlXk6FA2zefWhYXM4bukbFtxHI1a70ms3c2WB4DlLHjl8hfo9N+b31B2
         aoykT7M3NYXHEhiaHGLV7G4ZbbGAlGkfg06NtnoNw+EiUsEL/zfPpqjci1KTua+183Me
         OsOp4BqxsKI/HXA3WoehGxnhNK0cWpfbiYFnSxUwl8tyFy82+WWfQQWlwARq7b/5kbWI
         ZJa0RMcAK4QLTYStXeqh1B+BCwBam7l4JWsx8XpOLbt8QT+1pKUqbLF9G+Ex+gF21Nqs
         ZXlQ==
X-Gm-Message-State: ACrzQf3avDTcEdN5QfkHftUmdkIh6AoVCCYCYLPbWDYFNXFeGhjz/zyB
        pml17MQzARyUHTcVvpaFMrE=
X-Google-Smtp-Source: AMsMyM5DZiwM8N03fPJHH3U57Az3fKRX1q6ewEIeXynjcd5SgtSK3pqAB77bFRHqKdmAkNc35ca3bQ==
X-Received: by 2002:a05:6a00:238d:b0:563:b212:9257 with SMTP id f13-20020a056a00238d00b00563b2129257mr17182333pfc.21.1666324545714;
        Thu, 20 Oct 2022 20:55:45 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-47.three.co.id. [116.206.12.47])
        by smtp.gmail.com with ESMTPSA id ge12-20020a17090b0e0c00b0020aa1bd91e4sm621709pjb.4.2022.10.20.20.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:55:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5F01E103FE6; Fri, 21 Oct 2022 10:55:41 +0700 (WIB)
Date:   Fri, 21 Oct 2022 10:55:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v4 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
Message-ID: <Y1IYPTOJaxTfLDQe@debian.me>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="icZ6/z54STqGtU0x"
Content-Disposition: inline
In-Reply-To: <20221020212610.697729-2-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--icZ6/z54STqGtU0x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 02:26:07PM -0700, matthew.gerlach@linux.intel.com w=
rote:
> +Device Feature Header - Version 0
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The format of Version 0 of a Device Feature Header (DFH) is shown below::
> +
> +    +-------------------------------------------------------------------=
----+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 =
ID 0| 0x00
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_L                          =
   0| 0x08
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_H                          =
   0| 0x10
> +    +-------------------------------------------------------------------=
----+
> +
> +Offset 0x00
> +Type - The type of DFH (e.g. FME, AFU, or private feature).
> +DFH VER - The version of the DFH.
> +Rsvd - Currently unused.
> +EOL - Set if this DFH is the end of the Device Feature List (DFL).
> +Next - The offset of the next DFH in the DFL from the start of the DFH.
> +If EOL is set, Next refers to size of mmio for last feature in the list.
> +ID - If Type field is 'private feature', then ID of the private feature.
> +
> +Offset 0x08
> +GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifi=
er
> +if Type is FME or AFU.
> +
> +Offset 0x10
> +GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
> +if Type is FME or AFU.
> +
> +
> +Device Feature Header - Version 1
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The format of Version 1 of a Device Feature Header (DFH) is shown below::
> +
> +    +-------------------------------------------------------------------=
----+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 VER 12|11 =
ID 0| 0x00
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_L                          =
   0| 0x08
> +    +-------------------------------------------------------------------=
----+
> +    |63                                 GUID_H                          =
   0| 0x10
> +    +-------------------------------------------------------------------=
----+
> +    |63                 Address/Offset                            1|  Re=
l  0| 0x18
> +    +-------------------------------------------------------------------=
----+
> +    |63        Reg Size       32|Params 31|30 Group    16|15 Instance   =
   0| 0x20
> +    +-------------------------------------------------------------------=
----+
> +    |63 Next      34|RSV33|EOP32|31 Param Version 16|15 Param ID        =
   0| 0x28
> +    +-------------------------------------------------------------------=
----+
> +    |63                 Parameter Data                                  =
   0| 0x30
> +    +-------------------------------------------------------------------=
----+
> +
> +                                  ...
> +
> +    +-------------------------------------------------------------------=
----+
> +    |63 Next parameter offset 32|31 Param Version 16|15 Param ID        =
   0|
> +    +-------------------------------------------------------------------=
----+
> +    |63                 Parameter Data                                  =
   0|
> +    +-------------------------------------------------------------------=
----+
> +
> +Offset 0x00
> +Type - The type of DFH (e.g. FME, AFU, or private feature).
> +DFH VER - The version of the DFH.
> +Rsvd - Currently unused.
> +EOL - Set if this DFH is the end of the Device Feature List (DFL).
> +Next - The offset of the next DFH in the DFL from the start of the DFH.
> +If EOL is set, Next refers to size of mmio for last feature in the list.
> +ID - If Type field is 'private feature', then ID of the private feature.
> +
> +Offset 0x08
> +GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifi=
er.
> +
> +Offset 0x10
> +GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
> +if Type is FME or AFU.
> +
> +Offset 0x18
> +Address/Offset - If Rel bit is set, then high 63 bits of a 16 bit aligned
> +absolute address for the location of the feature's registers.
> +If Rel bit is clear, then the feature's registers start at the
> +offset from the start of the DFH.
> +
> +Offset 0x20
> +Reg Size - Size of feature's register set.
> +Params - Set if DFH has one or more parameter blocks.
> +Group - Id of group if feature is part of a group.
> +Instance - Id of instance of feature within a group.
> +
> +Offset 0x28 if feature has parameters
> +Next - High 30 bits of a 32 bit aligned offset to the next parameter blo=
ck.
> +If EOP set, size of last parameter.
> +Param Version - Version of Param ID.
> +Param ID - ID of parameter.
> +
> +Offset 0x30
> +Parameter Data - Parameter data whose size and format is defined by vers=
ion
> +and ID of the parameter.
> +

The offset fields list should be formatted with nested list (with
prose improv):

---- >8 ----

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 12365be435a812..9c19ee62d4ac44 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -573,22 +573,27 @@ The format of Version 0 of a Device Feature Header (D=
FH) is shown below::
     |63                                 GUID_H                            =
 0| 0x10
     +---------------------------------------------------------------------=
--+
=20
-Offset 0x00
-Type - The type of DFH (e.g. FME, AFU, or private feature).
-DFH VER - The version of the DFH.
-Rsvd - Currently unused.
-EOL - Set if this DFH is the end of the Device Feature List (DFL).
-Next - The offset of the next DFH in the DFL from the start of the DFH.
-If EOL is set, Next refers to size of mmio for last feature in the list.
-ID - If Type field is 'private feature', then ID of the private feature.
+The fields are:
=20
-Offset 0x08
-GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier
-if Type is FME or AFU.
+  * Offset 0x00
=20
-Offset 0x10
-GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
-if Type is FME or AFU.
+    * Type - The type of DFH (e.g. FME, AFU, or private feature).
+    * DFH VER - The version of the DFH.
+    * Rsvd - Currently unused.
+    * EOL - Set if this DFH is the end of the Device Feature List (DFL).
+
+    * Next - The offset of the next DFH in the DFL from the start of the D=
FH.
+      If EOL is set, Next refers to size of mmio for last feature in the l=
ist.
+
+    * ID - Private feature ID if Type is private feature.
+
+  * Offset 0x08
+
+    * GUID_L - Least significant half of a 128-bit GUID if Type is FME or =
AFU.
+
+  * Offset 0x10
+
+    * GUID_H - Most significant half of a 128-bit GUID if Type if FME or A=
FU.
=20
=20
 Device Feature Header - Version 1
@@ -619,43 +624,53 @@ The format of Version 1 of a Device Feature Header (D=
FH) is shown below::
     |63                 Parameter Data                                    =
 0|
     +---------------------------------------------------------------------=
--+
=20
-Offset 0x00
-Type - The type of DFH (e.g. FME, AFU, or private feature).
-DFH VER - The version of the DFH.
-Rsvd - Currently unused.
-EOL - Set if this DFH is the end of the Device Feature List (DFL).
-Next - The offset of the next DFH in the DFL from the start of the DFH.
-If EOL is set, Next refers to size of mmio for last feature in the list.
-ID - If Type field is 'private feature', then ID of the private feature.
+The fields are:
=20
-Offset 0x08
-GUID_L - Least significant 64 bits of a 128 bit Globally Unique Identifier.
+  * Offset 0x00
=20
-Offset 0x10
-GUID_H - Most significant 64 bits of a 128 bit Globally Unique Identifier
-if Type is FME or AFU.
+    * Type - The type of DFH (e.g. FME, AFU, or private feature).
+    * DFH VER - The version of the DFH.
+    * Rsvd - Currently unused.
+    * EOL - Set if this DFH is the end of the Device Feature List (DFL).
=20
-Offset 0x18
-Address/Offset - If Rel bit is set, then high 63 bits of a 16 bit aligned
-absolute address for the location of the feature's registers.
-If Rel bit is clear, then the feature's registers start at the
-offset from the start of the DFH.
+    * Next - The offset of the next DFH in the DFL from the start of the D=
FH.
+      If EOL is set, Next refers to size of mmio for last feature in the l=
ist.
=20
-Offset 0x20
-Reg Size - Size of feature's register set.
-Params - Set if DFH has one or more parameter blocks.
-Group - Id of group if feature is part of a group.
-Instance - Id of instance of feature within a group.
+    * ID - Private feature ID if Type is private feature.
=20
-Offset 0x28 if feature has parameters
-Next - High 30 bits of a 32 bit aligned offset to the next parameter block.
-If EOP set, size of last parameter.
-Param Version - Version of Param ID.
-Param ID - ID of parameter.
+  * Offset 0x08
=20
-Offset 0x30
-Parameter Data - Parameter data whose size and format is defined by version
-and ID of the parameter.
+    * GUID_L - Least significant half of a 128-bit GUID if Type is FME or =
APU.
+
+  * Offset 0x10
+
+    * GUID_H - Most significant half of a 128-bit GUID if Type is FME or A=
FU.
+
+  * Offset 0x18
+
+    * Address/Offset - If Rel bit is set, upper 63 bits of a 16-bit aligned
+      absolute address for the location of feature registers; otherwise
+      registers of the feature start at the offset from the start of the D=
FH.
+
+  * Offset 0x20
+
+    * Reg Size - Size of register set of the feature.
+    * Params - Set if DFH has one or more parameter blocks.
+    * Group - ID of group if the feature is part of a group.
+    * Instance - ID of instance of the feature within a group.
+
+  * Offset 0x28 (if the feature has parameters)
+
+    * Next - Upper 30 bits of a 32-bit aligned offset to the next parameter
+      block. If EOP is set, size of last parameter.
+
+    * Param Version - Version of Param ID.
+    * Param ID - ID of parameter.
+
+  * Offset 0x30 (if the feature has parameters)
+
+    * Parameter Data - Parameter data whose size and format is defined by
+      version and ID of the parameter.
=20
 Open discussion
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--icZ6/z54STqGtU0x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1IYNAAKCRD2uYlJVVFO
o3gUAP0Yh1JTkSmxymEiX2a1plGuyODDSuooDcM31Zbjx/rM6gD+O4gO7+nGen0R
QssNkcBsppgvjIM+IZHfdiAYu6Qa9A0=
=1io5
-----END PGP SIGNATURE-----

--icZ6/z54STqGtU0x--
